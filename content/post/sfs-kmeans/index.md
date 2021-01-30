---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Shit From Scratch in Julia: K-means clustering"
subtitle: ""
summary: ""
authors: [Annie C.]
tags: []
categories: []
date: 2020-12-20T12:09:59-04:00
lastmod: 2020-12-20T12:09:59-04:00
featured: true
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

projects: []
---

With so many built-in `Python` and `R` packages that allow you to perform complicated statistical tasks with a single command, why bother? For those coming into the ML world largely self-taught (like myself), it's _far_ too easy to fall into the trap of simple plug and play. Granted, we all do this to some extent -- we only have so much time and everyone picks their battles. Yet, to acquire a more complete understanding of any technique, we must invest time into dissecting its mechanics. 

As a doubly-whammy, I am also trying to learn to program in `Julia`. Hence, the genesis of "Shit From Scratch in `Julia`" (SFS.jl). This series kicks off with an unsupervised learning technique: k-means clustering. 

### Brief description of the k-means algorithm

1. Choose random centroids
Do until convergence:
- Update $\tau_i$ -- find closest centroid for each observation
- Update $\theta_k$ -- calculate new centroids
- Update change in objective function

### Coding it up

```python
# load all the packages we're using
using DataFrames, CSV
using Statistics, Random, Distributions
using Distances
using Plots
using RCall
@rlibrary ggplot2
```

As a test case, I'm going to be using a classic in the political science world, ideological positions of US Senators and Representatives estimated with roll call votes (DW-nominate scores).

```python
HS096_members = CSV.read("./data/HS096_members.csv", DataFrame)
x = select(HS096_members, [:nominate_dim1, :nominate_dim2])
# number of clusters
k = 4
```

We begin by using random centroids.
```python
# create matrix of k rows by 2 nominate dimensions
centers = Matrix{Float64}(undef, k, size(x,2))

# for each column
# generate 4 numbers from a uniform distribution
# bounded by the values of the nominate scores (max and min)
for i = 1:size(centers,2)
    # uniform over [a,b]
    a = minimum(x[:, i])
    b = maximum(x[:, i])
    D = Uniform(a, b)
    centers[:,i] = rand(D, k)
end
```

Now, we want to reassign each point to the closest centroid
```python
# for each row in data
new_assign = Vector{Float64}(undef, size(x,1))
for i = 1:size(x, 1)

    x_i = Array(x[i,:])
    dists = Vector{Float64}(undef, k)

    # for each k value, calculate the distance between observed x and the generated center
    for j = 1:k
        dists[j] = Distances.euclidean(x_i,  centers[j,:])
    end
    # take the index of the one with the smallest distance
    new_assign[i] = argmin(dists)
end

x.new_assign = categorical(new_assign)
center_df = DataFrame(nominate_dim1 = centers[:,1], nominate_dim2 = centers[:,2])
```

What do the clusters look like after one iteration? (cheating here a little here by using ggplot for the plotting)
```r
ggplot(x, aes(x = :nominate_dim1, y = :nominate_dim2, color = new_assign)) +
    geom_point() +
    geom_point(data = center_df,
    aes(:nominate_dim1, :nominate_dim2), color = "red")
```

Before repeating these steps, we should create a function to calculate the loss.
```python
function compute_loss(x, k, centers)
    loss = 0
    for i = 1:size(x, 1)
        x_i = Array(x[i,:])
        dists = Vector{Float64}(undef, k)
        for j = 1:k
            dists[j] = Distances.euclidean(x_i,  centers[j,:])
        end
    # choose loss fxn as squared min of distance
        loss = loss + minimum(dists)^2
    end
    return(loss)
end

compute_loss(x, k, centers)
```

Lastly, we want to iterate this process. To do so, let's compile all the above into a single function:
```python
function manual_kmeans(x, K, max_iter, epsilon, seed)
    Random.seed!(seed)

    centers = Matrix{Float64}(undef, K, size(x,2))

    for i = 1:size(centers,2)
        # uniform over [a,b]
        a = minimum(x[:, i])
        b = maximum(x[:, i])
        D = Uniform(a, b)
        centers[:,i] = rand(D, K)
    end

    # initial loss
    # uses t-1 centers and assignments given those centers
    old_loss = compute_loss(x, K, centers)

    change = 2 * epsilon
    iter = 0
    # assign to centroids
    assign = Vector{Float64}(undef, size(x,1))

    while (change > epsilon) && (iter < max_iter)

        for i = 1:size(x, 1)

            x_i = Array(x[i,:])
            dists = Vector{Float64}(undef, K)

            for j = 1:K
                dists[j] = Distances.euclidean(x_i,  centers[j,:])
            end
            assign[i] = argmin(dists)
        end

        # new centroids
        centers = Matrix{Float64}(undef, K, size(x, 2))
        for i = 1:size(centers, 1)
            centers[i, :] = mean.(eachcol(x[assign .== i, :]))
        end

        # update change in loss
        new_loss = compute_loss(x, K, centers)
        change = old_loss - new_loss
        old_loss = new_loss

        iter += 1
    end

    #out = Array{Any}([assign, centers, iter, old_loss])
    out = [assign, centers, iter, old_loss]
    return(out)
end


manual_out = manual_kmeans(x, 2, 1000, .001, 1234)
x.assignments = manual_out[1]
centers_df = DataFrame(dim1 = manual_out[2][1:3], dim2 = manual_out[2][4:6])
```

Plot final clustering!
```r
ggplot(x, aes(x = :nominate_dim1, y = :nominate_dim2, color = :assignments)) +
    geom_point() +
    geom_point(data = centers_df,
    aes(:dim1, :dim2), color = "red")
```












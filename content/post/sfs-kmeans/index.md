---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Shit From Scratch (SFS): K-means clustering"
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

# The K-means Algorithm

1. Choose random centroids
Do until convergence:
- Update $\tau_i$ -- find closest centroid for each observation
- Update $\theta_k$ -- calculate new centroids
- Update change in objective function

# Coding it up

```julia
# load all the packages we're using
using DataFrames, CSV
using Statistics, Random, Distributions
using Distances
using Plots
using RCall
@rlibrary ggplot2
```

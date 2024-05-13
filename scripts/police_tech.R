library(tidyverse)

#https://atlasofsurveillance.org/atlas
eff_data <- read_csv("./data/blog/Atlas of Surveillance-20230930.csv")

eff_data %>%
  count(Technology)


eff_data %>%
  count(City)


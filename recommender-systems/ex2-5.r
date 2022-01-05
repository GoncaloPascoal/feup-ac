
# Using Clustering Results
# Ex. 2

library(dplyr, warn.conflicts = FALSE)

log <- read.csv("log.csv")
matrix <- table(log)
dist <- dist(matrix)

model <- hclust(dist)
plot(model, main = "Cluster Dendogram")
plot(model, hang = -0.1, main = "Cluster Dendogram (hang = -0.1)")

print(cutree(model, k = 2))

plot(model, hang = -0.1, main = "Cluster Dendogram (2 clusters)")
rect.hclust(model, k = 2)

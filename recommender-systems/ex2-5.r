
# Using Clustering Results

library(dplyr, warn.conflicts = FALSE)

# Ex. 2
log <- read.csv("log.csv")
matrix <- table(log)
dist <- dist(matrix)

model <- hclust(dist)
plot(model, main = "Cluster Dendogram")
plot(model, hang = -0.1, main = "Cluster Dendogram (hang = -0.1)")

print(cutree(model, k = 2))

plot(model, hang = -0.1, main = "Cluster Dendogram (2 clusters)")
rect.hclust(model, k = 2)

model <- cutree(model, k = 2)

df <- as.data.frame(model)

recommend_cluster <- function(log, df, cluster) {
    members <- rownames(filter(df, model == cluster))
    log <- filter(log, USER %in% members)
    hits <- log %>% group_by(PAGE) %>% summarize(n()) %>% rename(hits = "n()")
    hits <- hits[order(hits$hits, decreasing = TRUE), ]
    return(hits)
}

# Ex. 3
print("Cluster 1 recommendations:")
recommend_cluster(log, df, 1)[1:2, ]

# Ex. 4
print("Cluster 2 recommendations:")
recommend_cluster(log, df, 2)[1:2, ]

# Ex. 5
print("User 2 recommendations (excluding visited pages):")
recs <- recommend_cluster(log, df, model[2])
visited <- filter(log, USER == "u2")[["PAGE"]]
recs <- filter(recs, !(PAGE %in% visited))
recs

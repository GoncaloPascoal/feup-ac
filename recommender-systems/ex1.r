
# Ex. 1: Most Visited Pages

library(dplyr, warn.conflicts = FALSE)

log <- read.csv("log.csv")
hits <- log %>% group_by(PAGE) %>% summarize(n()) %>% rename(hits = "n()")
hits <- hits[order(hits$hits, decreasing = TRUE), ]

print("The three most visited pages are:")
hits[1:3, ]

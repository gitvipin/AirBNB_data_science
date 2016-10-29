#!/usr/bin/env Rscript

# Collection of all plots for the data. 

ggplot(air, aes(did_search)) + geom_histogram(binwidth = 5)

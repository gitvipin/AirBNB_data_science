#!/usr/bin/env Rscript
library(ggplot2)
airdata = read.table("./data/airbnb.txt", sep="|", header = TRUE, na.strings = c("", "NA"))

# show info about data
str(airdata)
names(data)


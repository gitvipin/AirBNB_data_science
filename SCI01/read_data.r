#!/usr/bin/env Rscript
library(ggplot2)
airdata = read.table("./data/airbnb.txt", sep="|", header = TRUE, na.strings = c("", "NA"))
str(airdata)
plot <-ggplot(airdata, aes(did_search)) + geom_histogram(binwidth = 5)

ggsave(filename="./output/plots/myPlot.pdf", plot=plot)


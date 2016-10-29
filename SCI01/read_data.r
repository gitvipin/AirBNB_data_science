library(ggplot2)
air = read.table("air_exp.txt", sep="|", header = TRUE, na.strings = c("", "NA"))
ggplot(air, aes(did_search)) + geom_histogram(binwidth = 5)


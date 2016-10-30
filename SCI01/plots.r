#!/usr/bin/env Rscript

source ("read_data.R")
# Collection of all plots for the data. 

OUTPUT_PATH <- "./output/plots/"
EXTENSION <- "jpeg" # "pdf"

# A simple histogram of did_search
plot <-ggplot(airdata, aes(did_search)) + geom_histogram(binwidth = 5)
fname <- paste(OUTPUT_PATH, "did_search_histogram", ".", EXTENSION, sep="")
ggsave(filename=fname, plot=plot)

# Correlation between did_search and sent_message 
# Show as NEGATIVE Test case in presentation as en example of how choice of variable matters for right plots ?
plot <-ggplot(airdata, aes(did_search, sent_message)) + geom_point(color="green", size=7)
fname <- paste(OUTPUT_PATH, "correlation_search_vs_message", ".", EXTENSION, sep="")
ggsave(filename=fname, plot=plot, device = "jpeg")




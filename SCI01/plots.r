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

<<<<<<< HEAD
# This plot calculates the frequency of session lengths in histogram.
t_start = as.numeric(as.POSIXct(airdata$ts_min, format='%Y-%m-%d %H:%M:%S'))
t_stop = as.numeric(as.POSIXct(airdata$ts_max, format='%Y-%m-%d %H:%M:%S'))
session_lengths = as.integer((t_stop - t_start)/60)
plot <- ggplot() + aes(session_lengths) + geom_histogram(binwidth = 50, colour="black", fill="red")
fname <- paste(OUTPUT_PATH, "session_frequency", ".", EXTENSION, sep="")
ggsave(filename=fname, plot=plot, device = "jpeg")
=======


>>>>>>> 3740225d51c17c4503452e0d7a145cdab7876767

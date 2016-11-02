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

# This plot calculates the frequency of session lengths in histogram.
t_start = as.numeric(as.POSIXct(airdata$ts_min, format='%Y-%m-%d %H:%M:%S'))
t_stop = as.numeric(as.POSIXct(airdata$ts_max, format='%Y-%m-%d %H:%M:%S'))
airdata$session_lengths = as.integer((t_stop - t_start)/60)
plot <- ggplot() + aes(airdata$session_lengths) + geom_histogram(binwidth = 50, colour="black", fill="red")
fname <- paste(OUTPUT_PATH, "session_frequency", ".", EXTENSION, sep="")
ggsave(filename=fname, plot=plot, device = "jpeg")

plot <- qplot(airdata$dim_session_number, airdata$session_lengths) +
  labs(title="Airbnb user session order and duration(May 2014 to April 2015)",
       x="Session number", y= "Session duration(minutes)", colour = "Cylinders") +
  ylim(0,500) + xlim(0, 700)
fname <- paste(OUTPUT_PATH, "plot1", ".", EXTENSION, sep="")
ggsave(filename=fname, plot=plot, device = "jpeg")

plot <- ggplot(airdata, aes(dim_session_number, session_lengths, color=sent_message)) +
  geom_point() +
  scale_x_continuous(name="Session number", limits=c(0, 800), breaks=seq(0,800, 100)) +
  scale_y_continuous(name="Session duration(minutes)", limits=c(0, 500), breaks=seq(0, 500, 100))
fname <- paste(OUTPUT_PATH, "plot2", ".", EXTENSION, sep="")
ggsave(filename=fname, plot=plot, device = "jpeg")
  

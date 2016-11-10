#!/usr/bin/env Rscript
library(ggplot2)
airdata = read.table("./data/airbnb.txt", sep="|", header = TRUE, na.strings = c("", "NA"))

# Compute the Session Lengths based on the start and stop time stamps.
t_start = as.numeric(as.POSIXct(airdata$ts_min, format='%Y-%m-%d %H:%M:%S'))
t_stop = as.numeric(as.POSIXct(airdata$ts_max, format='%Y-%m-%d %H:%M:%S'))
t_start_next = as.numeric(as.POSIXct(airdata$next_ts_min, format='%Y-%m-%d %H:%M:%S'))
t_stop_next = as.numeric(as.POSIXct(airdata$next_ts_max, format='%Y-%m-%d %H:%M:%S'))
airdata$session_lengths = as.integer((t_stop - t_start)/60) #+ as.integer((t_start_next - t_stop_next)/60)


# Compute the Day of the week from data.
airdata$day <- weekdays(as.Date(airdata$ds))
airdata$month <- months(as.Date(airdata$ds))
# show info about data
str(airdata)
names(data)


# What are the chances if someone sends a message, he/she will make a booking request.
c1 <- cor(airdata$sent_message, airdata$sent_booking_request) # 0.21
print(paste0("Correlation between sent_message, sent_booking_request: ", c1))

# What are the chances that one will send the message if searches a property ?
c2 <- cor(airdata$did_search, airdata$sent_message) # 0.04
print(paste0("Correlation between sent_message, did_search: ", c2))


# Does someone's staying more on site means increased chances of booking ? 
c3 <- cor(as.numeric(airdata$session_lengths), airdata$sent_booking_request, use="complete") # 0.15
print(paste0("Correlation between session_length, did_booking: ", c3))


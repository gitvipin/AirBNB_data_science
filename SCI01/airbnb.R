# author : Tina Dai

##Open any data source
data = read.table(file.choose(), sep = "|", header = TRUE, na.strings = c("", "NA"))

#omit na
na.omit(data)

##library
library(ggplot2)

##bar graph #1 - first line sorts ascending, second line makes graph and formats
data <- within(data, dim_device_app_combo <- factor(dim_device_app_combo, levels=names(sort(table(dim_device_app_combo), decreasing=TRUE))))

ggplot(data, aes(x=dim_device_app_combo)) + geom_bar(fill = 'darkgreen') + ggtitle("User device and app usuage, May '14 - April '15") +
labs(x="Device",y="Frequency") + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())

##split column by space
library(stringr)
data$ts_min_time = str_split_fixed(data$ts_min, " ", 2)[,2]
data$ts_max_time = str_split_fixed(data$ts_max, " ", 2)[,2]

##string to time
library(lubridate)
data$ts_max_hms = ymd_hms( as.character(data$ts_max) )
data$ts_min_hms = ymd_hms( as.character(data$ts_min) )

##string to time & data difference
library(lubridate)
data$sessiontime = as.period(ymd_hms( as.character(data$ts_max) )- ymd_hms( as.character(data$ts_min) ))
data$sessiontimemins = as.numeric(data$sessiontime)/60

##histogram graph #2 - first line sorts ascending, second line makes graph and formats
ggplot(data,aes(sessiontimemins)) + geom_histogram(fill = 'darkgreen', binwidth = 1, color = 'white') + scale_x_sqrt()+ ggtitle("Select user session duration, May '14 - April '15") +
labs(x="Session duration (mins)",y="Frequency") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 

##boxplot #3 - first line sorts ascending, second line makes graph and formats
ggplot(data,aes(x=dim_device_app_combo,y=sessiontimemins)) + geom_boxplot(fill = 'darkgreen')+ ggtitle("User device and session time, May '14 - April '15") +
labs(x="Device",y="Session time (mins)") + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + ylim(0,200)

##average session time by id_visitor
avg_sessiontime = aggregate(sessiontimemins ~ id_visitor, data=data, FUN=mean_se)

##average session number by id_visitor
avg_sessiontime$avg_sessionnumber = aggregate(dim_session_number ~ id_visitor, data=data, FUN=mean_se)[,2]

##search by id_visitor
avg_sessiontime$search = aggregate(did_search ~ id_visitor, data=data, FUN=mean_se)[,2]

##message by id_visitor
avg_sessiontime$message = aggregate(sent_message ~ id_visitor, data=data, FUN=mean_se)[,2]

##booking by id_visitor
avg_sessiontime$booking = aggregate(sent_booking_request ~ id_visitor, data=data, FUN=mean_se)[,2]

##consolidated column
avg_sessiontime$behavior = ifelse(avg_sessiontime$booking > '0', "Booking requested", ifelse(avg_sessiontime$message > '0' & avg_sessiontime$booking == '0', "Messaged", 
                                                                                             ifelse(avg_sessiontime$search > '0' & average_sessiontime$booking =='0' & avg_sessiontime$message == '0', "Searched only", "No action taken")))

##scatterplot #4
newData=data.frame(avg_sessionnumber=unlist(avg_sessiontime$avg_sessionnumber),
                   sessiontimemins=unlist(avg_sessiontime$sessiontimemins), behavior=unlist(avg_sessiontime$behavior))

ggplot(newData, aes(x=avg_sessionnumber, y=sessiontimemins)) +  geom_point(aes(colour = factor(behavior.y))) + ggtitle("User days online and average session duration, May '14 - April '15") +
  labs(x="Number of days online",y="Session time (mins)", color="Legend") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + ylim(0,100) + xlim(0,120)

##scatterplot #5 (pre #4)

data$behavior = ifelse(data$sent_booking_request == '1', "Booking requested", ifelse(data$sent_message == '1' & data$sent_booking_request== '0', "Messaged",  
                                                                                     ifelse(data$did_search == '1' & data$sent_message == '0' & data$sent_booking_request== '0',"Searched only", "*Other action taken")))

ggplot(data, aes(x=dim_session_number, y=sessiontimemins)) +  geom_point(aes(colour = factor(behavior))) + ggtitle("User session number and duration, May '14 - April '15") +
  labs(x="Session number",y="Session time (mins)", color="Legend") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + ylim(0,500) + xlim(0,800)

##scatterplot #6
data <- within(data, behavior <- factor(behavior, levels=names(sort(table(behavior), decreasing=TRUE))))

ggplot(data, aes(behavior, fill=dim_device_app_combo)) + geom_bar() + labs(x="Action taken",y="Number of sessions", fill="Legend") + ggtitle("Action taken by session, May '14 - April '15")

##scatterplot #7
newData <- within(newData, behavior.y <- factor(behavior.y, levels=names(sort(table(behavior.y), decreasing=TRUE))))

ggplot(newData, aes(behavior.y)) + geom_bar(fill= 'darkgreen') + labs(x="Action taken",y="Number of sessions") + ggtitle("Average user action taken, May '14 - April '15")


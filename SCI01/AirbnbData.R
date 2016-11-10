# author : Tina Dai

#To import data since error occurs thorugh other methods. 
airbnb = read.table(file.choose(), sep = "|", header = TRUE, na.strings = c("", "NA"))
airbnb2<-na.omit(airbnb)

library(lubridate)
airbnb2$sessionTime = as.period(ymd_hms( as.character(airbnb2$ts_max) )- ymd_hms( as.character(airbnb2$ts_min)))

####################CLASSIFICATION MODEL
#Training Data
training = airbnb2[seq(1,nrow(airbnb2),2), c("did_search","sent_message","sent_booking_request")]
#Testing Data 
testing = airbnb2[seq(2,nrow(airbnb2),2),c("did_search","sent_message","sent_booking_request")]
#built a model
model <- train(sent_booking_request~.,training,method="kknn")
#meaure accuracy of model by testing results
testingResults <- as.character(predict(model,newdata=testing))

testingResults
testing$sent_booking_request

accuracy=sum(testingResults==testing$sent_booking_request)/length(testing$sent_booking_request)

####################PREDICTIVE MODEL, Linear Regression
model= train(sent_booking_request~.,data=airbnb2[,c(9,10,11)], method="kkn")
model$finalModel 

#################PREDICTIVE MODEL, R-SQUARED (ASSESSING ACCURACY)
model= train(sent_booking_request~.,data=airbnb2(seq(1,nrow(airbnb2),2), c(9,10,11)), method="kknn")
predictedBookings=predict(model,airbnb2[seq(2,nrow(airbnb2),2),c(9,10,11)])
#Calculate the R-Square
rsquare=1-sum((predictedBookings-airbnb2[seq(2,nrow(airbnb2),2),c(9,10,11)])^2)/
  sum((airbnb2$sent_booking_request-mean(airbnb2$sent_booking_request))^2)



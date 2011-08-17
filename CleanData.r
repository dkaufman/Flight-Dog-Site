## Remember to remove the colon in Jet Blue Flight times and convert dates


AT713 = read.csv("/Users/Daniel/Dropbox/AirTranMaster_7_13.txt")
names(AT713)[1]="ObservationDate"
names(AT713)[2]="FlightDate"
names(AT713)[3]="Origin"
names(AT713)[4]="Destination"
names(AT713)[5]="Price"
names(AT713)[6]="FlightNumber"
names(AT713)[7]="Stops"
names(AT713)[8]="Departs"
names(AT713)[9]="Arrives"
names(AT713)[10]="Duration"
names(AT713)[11]="Seats"
AT83 = read.csv("/Users/Daniel/Dropbox/AirTranMaster_8_3.txt")
names(AT83)[1]="ObservationDate"
names(AT83)[2]="FlightDate"
names(AT83)[3]="Origin"
names(AT83)[4]="Destination"
names(AT83)[5]="Price"
names(AT83)[6]="FlightNumber"
names(AT83)[7]="Stops"
names(AT83)[8]="Departs"
names(AT83)[9]="Arrives"
names(AT83)[10]="Duration"
names(AT83)[11]="Seats"
JB713 = read.csv("/Users/Daniel/Dropbox/JetBlueMaster_7_13.csv")
names(JB713)[1]="ObservationDate"
names(JB713)[2]="FlightDate"
names(JB713)[3]="Origin"
names(JB713)[4]="Destination"
names(JB713)[5]="Price"
names(JB713)[6]="FlightNumber"
names(JB713)[7]="Departs"
names(JB713)[8]="Arrives"
names(JB713)[9]="Seats"
JB83 = read.csv("/Users/Daniel/Dropbox/JetBlueMaster_8_3.csv")
names(JB83)[1]="ObservationDate"
names(JB83)[2]="FlightDate"
names(JB83)[3]="Origin"
names(JB83)[4]="Destination"
names(JB83)[5]="Price"
names(JB83)[6]="FlightNumber"
names(JB83)[7]="Departs"
names(JB83)[8]="Arrives"
names(JB83)[9]="Seats"


AT713$Airline = "AT"
AT83$Airline = "AT"
JB713$Airline = "JB"
JB83$Airline = "JB"

ATData = rbind(AT713, AT83)
ATData = ATData[which(ATData$Stops == "nonstop"),]
ATData$ObservationDate = strptime(ATData$ObservationDate, "%a %b %d %H:%M:%S %Y")
ATData$FlightDate = strptime(ATData$FlightDate, "%a %B %d %Y")
ATData$Departs = 60*trunc(ATData$Departs/100)+(ATData$Departs%%100)
ATData$Arrives = 60*trunc(ATData$Arrives/100)+(ATData$Arrives%%100)
ATData$Price = as.numeric(gsub('[^0-9]', '', ATData$Price))

JBData = rbind(JB713, JB83)
JBData$ObservationDate = strptime(JBData$ObservationDate, "%a %b %d %H:%M:%S %Y")
JBData$FlightDate = strptime(JBData$FlightDate, "%m %d %y")
JBData$Price = as.numeric(gsub('[^0-9]', '', JBData$Price))
JBData$Stops = "nonstop"
JBData$Departs = 60*trunc(JBData$Departs/100)+(JBData$Departs%%100)
JBData$Arrives = 60*trunc(JBData$Arrives/100)+(JBData$Arrives%%100)
JBData$Duration = as.numeric(JBData$Arrives) - as.numeric(JBData$Departs)


data = rbind(ATData, JBData)

data$ObservationDay = weekdays(data$ObservationDate)
data$FlightDay = weekdays(data$FlightDate)
data$FlightID = paste(data$Airline, data$FlightDate, data$Origin, data$Destination, data$FlightNumber)
data$FlightGroup = paste(data$Airline, data$ObservationDay, data$Origin, data$Destination, data$FlightNumber)
data$FlightTime = strptime(paste(data$FlightDate, trunc(data$Departs/60), data$Departs%%60), "%Y-%m-%d %H %M")
data$MinutesUntilFlight = as.numeric(difftime(data$FlightTime, data$ObservationDate, units = 'mins'))

data = data[which(!is.na(data$Price)),]
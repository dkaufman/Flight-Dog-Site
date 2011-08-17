IDSortedData <- data[order(data$FlightID, data$ObservationDate) , ]

remove(data)

IDSortedData$LastPrice <- append(IDSortedData$Price,0,0)[-nrow(IDSortedData)-1]
IDSortedData$LastMinutesUntilFlight <- append(IDSortedData$MinutesUntilFlight,0,0)[-nrow(IDSortedData)-1]
IDSortedData$LastSeats <- append(IDSortedData$Seats,0,0)[-nrow(IDSortedData)-1]
IDSortedData$LastFlightID <- append(IDSortedData$FlightID,0,0)[-nrow(IDSortedData)-1]

IDSortedData$LastPrice = (IDSortedData$LastFlightID == IDSortedData$FlightID)*IDSortedData$LastPrice
IDSortedData$LastMinutesUntilFlight = (IDSortedData$LastFlightID == IDSortedData$FlightID)*IDSortedData$LastMinutesUntilFlight
IDSortedData$LastSeats = (IDSortedData$LastFlightID == IDSortedData$FlightID)*IDSortedData$LastSeats

IDSortedData$LastPrice <- replace(IDSortedData$LastPrice, IDSortedData$LastPrice == 0, NA)
IDSortedData$LastMinutesUntilFlight <- replace(IDSortedData$LastMinutesUntilFlight, IDSortedData$LastMinutesUntilFlight == 0, NA)
IDSortedData$LastSeats <- replace(IDSortedData$LastSeats, IDSortedData$LastSeats == 0, NA)




IDSortedData$Delta = IDSortedData$Price - IDSortedData$LastPrice
IDSortedData$PriceIncreased = (IDSortedData$Delta>0)*1
IDSortedData$PriceDecreased = (IDSortedData$Delta<0)*1
IDSortedData$PriceChanges = (IDSortedData$PriceIncreased + IDSortedData$PriceDecreased)
IDSortedData$TimePassed = IDSortedData$LastMinutesUntilFlight - IDSortedData$MinutesUntilFlight




IDSortedData$OneFuturePrice = c(IDSortedData$Price[-1], NA)
IDSortedData$OneFutureSeats = c(IDSortedData$Seats[-1], NA)
IDSortedData$OneFutureMinutesUntilFlight = c(IDSortedData$MinutesUntilFlight[-1], NA)
IDSortedData$OneFutureFlightID = c(IDSortedData$FlightID[-1], NA)

IDSortedData$OneFuturePrice = (IDSortedData$OneFutureFlightID == IDSortedData$FlightID)*IDSortedData$OneFuturePrice
IDSortedData$OneFutureMinutesUntilFlight = (IDSortedData$OneFutureFlightID == IDSortedData$FlightID)*IDSortedData$OneFutureMinutesUntilFlight
IDSortedData$OneFutureSeats = (IDSortedData$OneFutureFlightID == IDSortedData$FlightID)*IDSortedData$OneFutureSeats

IDSortedData$OneFuturePrice <- replace(IDSortedData$OneFuturePrice, IDSortedData$OneFuturePrice == 0, NA)
IDSortedData$OneFutureMinutesUntilFlight <- replace(IDSortedData$OneFutureMinutesUntilFlight, IDSortedData$OneFutureMinutesUntilFlight == 0, NA)
IDSortedData$OneFutureSeats <- replace(IDSortedData$OneFutureSeats, IDSortedData$OneFutureSeats == 0, NA)



IDSortedData$TwoFuturePrice = c(IDSortedData$Price[-1:-2], NA, NA)
IDSortedData$TwoFutureSeats = c(IDSortedData$Seats[-1:-2], NA, NA)
IDSortedData$TwoFutureMinutesUntilFlight = c(IDSortedData$MinutesUntilFlight[-1:-2], NA, NA)
IDSortedData$TwoFutureFlightID = c(IDSortedData$FlightID[-1:-2], NA, NA)

IDSortedData$TwoFuturePrice = (IDSortedData$TwoFutureFlightID == IDSortedData$FlightID)*IDSortedData$TwoFuturePrice
IDSortedData$TwoFutureMinutesUntilFlight = (IDSortedData$TwoFutureFlightID == IDSortedData$FlightID)*IDSortedData$TwoFutureMinutesUntilFlight
IDSortedData$TwoFutureSeats = (IDSortedData$TwoFutureFlightID == IDSortedData$FlightID)*IDSortedData$TwoFutureSeats

IDSortedData$TwoFuturePrice <- replace(IDSortedData$TwoFuturePrice, IDSortedData$TwoFuturePrice == 0, NA)
IDSortedData$TwoFutureMinutesUntilFlight <- replace(IDSortedData$TwoFutureMinutesUntilFlight, IDSortedData$TwoFutureMinutesUntilFlight == 0, NA)
IDSortedData$TwoFutureSeats <- replace(IDSortedData$TwoFutureSeats, IDSortedData$TwoFutureSeats == 0, NA)






IDSortedData$ThreeFuturePrice = c(IDSortedData$Price[-1:-3], NA, NA, NA)
IDSortedData$ThreeFutureSeats = c(IDSortedData$Seats[-1:-3], NA, NA, NA)
IDSortedData$ThreeFutureMinutesUntilFlight = c(IDSortedData$MinutesUntilFlight[-1:-3], NA, NA, NA)
IDSortedData$ThreeFutureFlightID = c(IDSortedData$FlightID[-1:-3], NA, NA, NA)

IDSortedData$ThreeFuturePrice = (IDSortedData$ThreeFutureFlightID == IDSortedData$FlightID)*IDSortedData$ThreeFuturePrice
IDSortedData$ThreeFutureMinutesUntilFlight = (IDSortedData$ThreeFutureFlightID == IDSortedData$FlightID)*IDSortedData$ThreeFutureMinutesUntilFlight
IDSortedData$ThreeFutureSeats = (IDSortedData$ThreeFutureFlightID == IDSortedData$FlightID)*IDSortedData$ThreeFutureSeats

IDSortedData$ThreeFuturePrice <- replace(IDSortedData$ThreeFuturePrice, IDSortedData$ThreeFuturePrice == 0, NA)
IDSortedData$ThreeFutureMinutesUntilFlight <- replace(IDSortedData$ThreeFutureMinutesUntilFlight, IDSortedData$ThreeFutureMinutesUntilFlight == 0, NA)
IDSortedData$ThreeFutureSeats <- replace(IDSortedData$ThreeFutureSeats, IDSortedData$ThreeFutureSeats == 0, NA)





IDSortedData$FourFuturePrice = c(IDSortedData$Price[-1:-4], NA, NA, NA, NA)
IDSortedData$FourFutureSeats = c(IDSortedData$Seats[-1:-4], NA, NA, NA, NA)
IDSortedData$FourFutureMinutesUntilFlight = c(IDSortedData$MinutesUntilFlight[-1:-4], NA, NA, NA, NA)
IDSortedData$FourFutureFlightID = c(IDSortedData$FlightID[-1:-4], NA, NA, NA, NA)

IDSortedData$FourFuturePrice = (IDSortedData$FourFutureFlightID == IDSortedData$FlightID)*IDSortedData$FourFuturePrice
IDSortedData$FourFutureMinutesUntilFlight = (IDSortedData$FourFutureFlightID == IDSortedData$FlightID)*IDSortedData$FourFutureMinutesUntilFlight
IDSortedData$FourFutureSeats = (IDSortedData$FourFutureFlightID == IDSortedData$FlightID)*IDSortedData$FourFutureSeats

IDSortedData$FourFuturePrice <- replace(IDSortedData$FourFuturePrice, IDSortedData$FourFuturePrice == 0, NA)
IDSortedData$FourFutureMinutesUntilFlight <- replace(IDSortedData$FourFutureMinutesUntilFlight, IDSortedData$FourFutureMinutesUntilFlight == 0, NA)
IDSortedData$FourFutureSeats <- replace(IDSortedData$FourFutureSeats, IDSortedData$FourFutureSeats == 0, NA)





IDSortedData$FiveFuturePrice = c(IDSortedData$Price[-1:-5], NA, NA, NA, NA, NA)
IDSortedData$FiveFutureSeats = c(IDSortedData$Seats[-1:-5], NA, NA, NA, NA, NA)
IDSortedData$FiveFutureMinutesUntilFlight = c(IDSortedData$MinutesUntilFlight[-1:-5], NA, NA, NA, NA, NA)
IDSortedData$FiveFutureFlightID = c(IDSortedData$FlightID[-1:-5], NA, NA, NA, NA, NA)

IDSortedData$FiveFuturePrice = (IDSortedData$FiveFutureFlightID == IDSortedData$FlightID)*IDSortedData$FiveFuturePrice
IDSortedData$FiveFutureMinutesUntilFlight = (IDSortedData$FiveFutureFlightID == IDSortedData$FlightID)*IDSortedData$FiveFutureMinutesUntilFlight
IDSortedData$FiveFutureSeats = (IDSortedData$FiveFutureFlightID == IDSortedData$FlightID)*IDSortedData$FiveFutureSeats

IDSortedData$FiveFuturePrice <- replace(IDSortedData$FiveFuturePrice, IDSortedData$FiveFuturePrice == 0, NA)
IDSortedData$FiveFutureMinutesUntilFlight <- replace(IDSortedData$FiveFutureMinutesUntilFlight, IDSortedData$FiveFutureMinutesUntilFlight == 0, NA)
IDSortedData$FiveFutureSeats <- replace(IDSortedData$FiveFutureSeats, IDSortedData$FiveFutureSeats == 0, NA)


IDSortedData$OneDayLater = IDSortedData$MinutesUntilFlight - 1440

IDSortedData$OneFuturePlusOneDay = (IDSortedData$OneFutureMinutesUntilFlight <= IDSortedData$OneDayLater)*1
IDSortedData$TwoFuturePlusOneDay = (IDSortedData$TwoFutureMinutesUntilFlight <= IDSortedData$OneDayLater)*2
IDSortedData$ThreeFuturePlusOneDay = (IDSortedData$ThreeFutureMinutesUntilFlight <= IDSortedData$OneDayLater)*3
IDSortedData$FourFuturePlusOneDay = (IDSortedData$FourFutureMinutesUntilFlight <= IDSortedData$OneDayLater)*4
IDSortedData$FiveFuturePlusOneDay = (IDSortedData$FiveFutureMinutesUntilFlight <= IDSortedData$OneDayLater)*5

IDSortedData$OneFuturePlusOneDay = replace(IDSortedData$OneFuturePlusOneDay, IDSortedData$OneFuturePlusOneDay == 0, NA)
IDSortedData$TwoFuturePlusOneDay = replace(IDSortedData$TwoFuturePlusOneDay, IDSortedData$TwoFuturePlusOneDay == 0, NA)
IDSortedData$ThreeFuturePlusOneDay = replace(IDSortedData$ThreeFuturePlusOneDay, IDSortedData$ThreeFuturePlusOneDay == 0, NA)
IDSortedData$FourFuturePlusOneDay = replace(IDSortedData$FourFuturePlusOneDay, IDSortedData$FourFuturePlusOneDay == 0, NA)
IDSortedData$FiveFuturePlusOneDay = replace(IDSortedData$FiveFuturePlusOneDay, IDSortedData$FiveFuturePlusOneDay == 0, NA)

IDSortedData$BestOneDayObservation = pmin(IDSortedData$OneFuturePlusOneDay, 
                                          IDSortedData$TwoFuturePlusOneDay,
                                          IDSortedData$ThreeFuturePlusOneDay,
                                          IDSortedData$FourFuturePlusOneDay,
                                          IDSortedData$FiveFuturePlusOneDay, na.rm = TRUE)
                                          
OneDayPriceData = IDSortedData[which(!is.na(IDSortedData$BestOneDayObservation)),]
remove(IDSortedData)

OneDayPriceData = OneDayPriceData[which(OneDayPriceData$BestOneDayObservation > 1),]

OneDayPriceData$OneDayPriceCeiling =  (OneDayPriceData$BestOneDayObservation == 2)*OneDayPriceData$TwoFuturePrice +
                                      (OneDayPriceData$BestOneDayObservation == 3)*OneDayPriceData$ThreeFuturePrice +
                                      (OneDayPriceData$BestOneDayObservation == 4)*OneDayPriceData$FourFuturePrice +
                                      (OneDayPriceData$BestOneDayObservation == 5)*OneDayPriceData$FiveFuturePrice
                                      
OneDayPriceData$OneDayPriceFloor =    (OneDayPriceData$BestOneDayObservation == 2)*OneDayPriceData$OneFuturePrice +
                                      (OneDayPriceData$BestOneDayObservation == 3)*OneDayPriceData$TwoFuturePrice +
                                      (OneDayPriceData$BestOneDayObservation == 4)*OneDayPriceData$ThreeFuturePrice +
                                      (OneDayPriceData$BestOneDayObservation == 5)*OneDayPriceData$FourFuturePrice


OneDayPriceData = OneDayPriceData[which(!is.na(OneDayPriceData$OneDayPriceCeiling) & !is.na(OneDayPriceData$OneDayPriceFloor)),]

OneDayPriceData$OneDayPrice = (OneDayPriceData$OneDayPriceCeiling + OneDayPriceData$OneDayPriceCeiling)/2

FlightIDs = unique(data$FlightID)
pdf(file="/Users/Daniel/Dropbox/testplots.pdf") 
for (i in 1:length(FlightIDs)){
  ID = FlightIDs[i]
  plot(data[which(data$FlightID == ID),]$MinutesUntilFlight, data[which(data$FlightID == ID),]$Price, main = ID, lwd=3, type="l")
}
dev.off()

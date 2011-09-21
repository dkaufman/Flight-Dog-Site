def self.SWController
    #Get current Date
    currentYear = Time.now.year
    currentMonth = Time.now.month
    currentDay = Time.now.day
    leapYear = currentYear%4
    
    #Calculate how many days are in the current month
    if [4,6,9,11].include? currentMonth
    	daysInMonth = 30
    elsif currentMonth == 2 && leapYear == 0
    	daysInMonth = 29
    elsif currentMonth == 2
    	daysInmonth = 28
    else
    	daysInMonth = 31
    end
    
    #Collect flight data for flights between 6 and 25 days away
    puts "Started data collection " + Time.now.to_s
    for i in (6..25)
    	flightMonth = currentMonth
    	flightDay = currentDay + i
    	flightYear = currentYear
      if flightDay > daysInMonth
    		flightDay = flightDay - daysInMonth
    		flightMonth += 1
      end
      if flightMonth == 13
    		flightMonth = 1
    		flightYear += 1
      end
      if flightMonth < 10
    		flightMonth = "0" + flightMonth.to_s
      end
      if flightDay < 10
    		flightDay = "0" + flightDay.to_s
      end
    	formattedFlightDate = flightYear.to_s + "/" + flightMonth.to_s + "/" + flightDay.to_s
    end
    
    airportArray = ["BOS", "BWI"]
    
    j = airportArray.length - 1
    
    airportArray.each do |o|
      airportArray.each do |d|
        if o != d
          begin
    	      SWCollect(formattedFlightDate, o, d)
          rescue
    		    puts "***Failed to collect Southwest - " + o + " to " + d + " for " + formattedFlightDate
          end
        end
      end
    end
end

def self.SWCollect(date, fromCity, toCity)
  
  @date = "9/21/2011"
	@fromCity = "BOS"
	@toCity = "BWI" 

  agent = Mechanize.new
  url = "http://www.southwest.com/flight"
  homePage = agent.get(url)
  
  searchForm = homePage.forms[2]
  
  searchForm.radiobutton_with(:id => 'oneWay').check
  searchForm["originAirport"] = [@fromCity]
  searchForm["destinationAirport"] = [@toCity]
  searchForm["outboundDateString"] = [@date]
  results = agent.submit(searchForm)
  
  nonstopArray = results.search(".bugLinkRouting").map(&:text).map(&:strip)
  departsTimeArray = results.search("td:nth-child(1) .time").map(&:text).map(&:strip)
  departsAmPmArray = results.search("td:nth-child(1) .indicator").map(&:text).map(&:strip)
  arrivesTimeArray = results.search("td:nth-child(2) .time").map(&:text).map(&:strip)
  arrivesAmPmArray = results.search("td:nth-child(2) .indicator").map(&:text).map(&:strip)
  flightArray = results.search(".bugLinkText").map(&:text).map(&:strip)
  priceArray = results.search(".price_column:nth-child(8) .product_price").map(&:text).map(&:strip)
  
  departsArray = []
  arrivesArray = []
  
  j = departsTimeArray.length - 1
  
  for i in (0..j)    
    departsArray[i] = DateTime.strptime((departsTimeArray[i] + " " + departsAmPmArray[i]), '%I:%M %p')
    arrivesArray[i] = DateTime.strptime((arrivesTimeArray[i] + " " + arrivesAmPmArray[i]), '%I:%M %p')
  end
  
  
  j = flightsArray.length - 1
  for i in (0..j)
  		Flight.create(:airline => "SW", :observation_date => Time.now.ctime, :flight_date => @date, :origin => @fromCity, :destination => @toCity, :price => priceArray[i], :flight_number => flightsArray[i], :departs => departsArray[i], :arrives => arrivesArray[i])
  end
  
end
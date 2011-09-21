class Scrape < ActiveRecord::Base
    attr_accessible  :id, :created_at, :updated_at
    
  def self.initiate
    ATController()
    JBController()
    SWController()
  end
  
  private
  
  
  def self.SWController
    airportArray = ["BOS", "BWI", "MDW", "LAS", "PHX", "DEN", "HOU", "DAL", "LAX", "OAK", "MCO"]
    j = airportArray.length - 1
    
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
    	formattedFlightDate = flightMonth.to_s + "/" + flightDay.to_s + "/" + flightYear.to_s
      airportArray.each do |o|
        airportArray.each do |d|
          if o != d
            puts "Collecting Southwest - " + o + " to " + d + " for " + formattedFlightDate
            begin
              SWCollect(formattedFlightDate, o, d)
            rescue
              puts "***Failed to collect Southwest - " + o + " to " + d + " for " + formattedFlightDate
            end
          end
        end
      end
    end      
end

def self.SWCollect(date, fromCity, toCity)
  @date = date
	@fromCity = fromCity
	@toCity = toCity

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
  priceArray = priceArray.map {|x| x[/\d+/]}
  
  departsArray = []
  arrivesArray = []
  
  j = departsTimeArray.length - 1
  
  for i in (0..j)    
    departsArray[i] = DateTime.strptime((departsTimeArray[i] + " " + departsAmPmArray[i]), '%I:%M %p')
    arrivesArray[i] = DateTime.strptime((arrivesTimeArray[i] + " " + arrivesAmPmArray[i]), '%I:%M %p')
  end
  
  
  j = flightArray.length - 1
    for i in (0..j)
      if nonstopArray[i].include? "onstop"
  		  Flight.create(:airline => "SW", :observation_date => Time.now.ctime, :flight_date => @date, :origin => @fromCity, :destination => @toCity, :price => priceArray[i], :flight_number => flightArray[i], :departs => departsArray[i], :arrives => arrivesArray[i])
      end
    end

end
  
  def self.ATController
    airportArray = ["BOS", "BWI", "MKE", "ATL", "MCO", "RSW", "TPA", "IND", "LGA", "FLL"]
    
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
    #Each submission records 5 dates, need to only submit 8, 13, 18, 23
    puts "Started data collection " + Time.now.to_s
    for i in [8,13,18,23]
    	flightMonth = currentMonth
    	flightDay = currentDay + i
    	flightYear = currentYear
    	formattedFlightMonth = ""
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
    	formattedFlightMonth = flightYear.to_s + "-" + flightMonth.to_s
      airportArray.each do |o|
        airportArray.each do |d|
          if o != d
            puts "Collecting AirTran - " + o + " to " + d + " for " + formattedFlightMonth + "-" + flightDay.to_s
            begin
              ATCollect(flightDay.to_s, flightMonth.to_s, o, d)
            rescue
              puts "***Failed to collect AirTran - " + o + " to " + d + " for " + formattedFlightDate
            end
          end
        end
      end
    end
  end
  
  def self.JBController
    airportArray = ["BOS", "BWI", "MCO", "FLL", "JFK", "LGB", "IAD"]
    
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
    	formattedFlightDate = flightYear.to_s + "-" + flightMonth.to_s + "-" + flightDay.to_s
      airportArray.each do |o|
        airportArray.each do |d|
          if o != d
            puts "Collecting Jet Blue - " + o + " to " + d + " for " + formattedFlightDate
            begin
              JBCollect(formattedFlightDate, o, d)
            rescue
              puts "***Failed to collect Jet Blue - " + o + " to " + d + " for " + formattedFlightDate
            end
          end
        end
      end
  end
  end
  
  def self.JBCollect(date, fromCity, toCity)
		@date = date
		@fromCity = fromCity
		@toCity = toCity    

		#Open JetBlue reservations search page
		#In this case, the mobile page proved easier to navigate
		url = "http://mobile.jetblue.com/"
		agent = Mechanize.new
		homePage = agent.get(url)

		#Navigate to the one-way flight search, if not already on it
		searchPage = homePage.link_with(:text => "Book a flight").click
		oneWayLink = searchPage.link_with(:text => "Oneway")
		if oneWayLink.nil? == false
			searchPage = oneWayLink.click
		end

		#Fill out search form with flight information, store page with non-stop results
		searchForm = searchPage.form('searchForm')
		searchForm["origin"] = [@fromCity]
		searchForm["destination"] = [@toCity]
		searchForm["un_jtt_date1"] = [@date]
		results = agent.submit(searchPage.forms.first, searchPage.forms.first.buttons[3])
		nonstopResults = agent.submit(results.forms.first, results.forms.first.buttons.first)

		#Scrape price, departure time, arrival time, flight number, and seats remaining, store in arrays
		#All scrapes are based on CSS Selectors
		price_array = nonstopResults.search(".lmb_tb_b div div div b").map(&:text).map(&:strip)
    price_array = price_array.map {|x| x[/\d+/]}
		departs_array = nonstopResults.search(".lmb_tb_b div div div:nth-child(1)").map(&:text).map(&:strip)
		arrives_array = nonstopResults.search(".lmb_tb_b div:nth-child(2) div:nth-child(2)").map(&:text).map(&:strip)
		flights_array = nonstopResults.search("#outboundTable a").map(&:text).map(&:strip)
		seats_array = nonstopResults.search(".lmb_tb_b div:nth-child(4)").map(&:text).map(&:strip)

		#Clean departure array to remove initial text
		cleaned_departs_array = Array.new
		departs_array.each do |d|
			l = d.length
			cleaned_departs_array << d[10..l]
		end

		#Clean arrival array to remove initial text
		cleaned_arrives_array = Array.new
		arrives_array.each do |d|
			l = d.length
			cleaned_arrives_array << d[10..l]
		end

		#Clean seats remaining array to only number
		cleaned_seats_array = Array.new
		seats_array.each do |s|
			if s.include?("1")
				cleaned_seats_array << "1"
			elsif s.include?("2")
				cleaned_seats_array << "2"
			elsif s.include?("3")
				cleaned_seats_array << "3"
			elsif s.include?("4")
				cleaned_seats_array << "4"
			elsif s.include?("5")
				cleaned_seats_array << "5"
			else
				cleaned_seats_array << ""
			end
		end
    #@date = Date.strptime(@date, fmt='%m/%d/%Y')
		#Create output array of each flight record
		  output = Array.new
		  j = flights_array.length - 1
		  for i in (0..j)
					Flight.create(:airline => "JB", :observation_date => Time.now.ctime, :flight_date => @date, :origin => @fromCity, :destination => @toCity, :price => price_array[i], :flight_number => flights_array[i], :departs => cleaned_departs_array[i], :arrives => cleaned_arrives_array[i], :seats => cleaned_seats_array[i])
 		  end
	end
  
  def self.ATCollect(day, month, fromCity, toCity)
		@day = day
		@month = month
		@fromCity = fromCity
		@toCity = toCity
    
		#Open AirTran reservations search page
		url = "http://www.airtran.com/Home.aspx"
		agent = Mechanize.new
		page = agent.get(url)

		#Fill out SkySales form, Submit
		#Force one way, dates 2 days on either side from date
		skySales = page.form_with(:name => 'SkySales')
		skySales.radiobutton_with(:value => 'OneWay').check
		skySales["ATAvailabilitySearchInputSearchView$DropDownListMarketOrigin1"] = [@fromCity]
		skySales["ATAvailabilitySearchInputSearchView$DropDownListMarketDestination1"] = [@toCity]
		skySales["ATAvailabilitySearchInputSearchView$DropDownListMarketDay1"] = [@day]
		skySales["ATAvailabilitySearchInputSearchView$DropDownListMarketMonth1"] = [@month]
		skySales["ATAvailabilitySearchInputSearchView$DropDownListMarketDateRange1"] = ["2|2"]
		results = agent.submit(skySales)


		#Click on link for printable results
		printable_results = results.links.find { |l| l.text == 'Printer-friendly version' }.click

		#Scrape prices off printable results
		#All scrapes are based on CSS Selectors
		price_array = printable_results.search("td:nth-child(5)").map(&:text).map(&:strip)
    price_array = price_array.map {|x| x[/\d+/]}

		#Scrape seats remaining, clean seats remaining to just the number
		seats_array=printable_results.search("td:nth-child(6)").map(&:text).map(&:strip)
		final_seats_array = Array.new
		j = seats_array.length-1
		for i in (0..j)
			final_seats_array[i] = seats_array[i].first
		end
		cleaned_seats_array = Array.new
		final_seats_array.each do |s|
			if s.to_s.include? "$"
				cleaned_seats_array << ""
			elsif s.to_s.include? "1"
				cleaned_seats_array << "1"
			elsif s.to_s.include? "2"
				cleaned_seats_array << "2"
			elsif s.to_s.include? "3"
				cleaned_seats_array << "3"
			elsif s.to_s.include? "4"
				cleaned_seats_array << "4"
			elsif s.to_s.include? "5"
				cleaned_seats_array << "5"
			else
				cleaned_seats_array << ""
			end
		  end

		  #Scrape non-stop boolean, departure time, arrival time, flight duration
		  nonstop_array = printable_results.search("td:nth-child(4)").map(&:text).map(&:strip)
		  j = nonstop_array.length - 1
		  for i in (0..j)
		  	a = nonstop_array[i]
			if a.include?("non")
				nonstop_array[i] = "nonstop"
			else
				nonstop_array[i] = "multi-stop"
			end
		  end
		  departs_array = printable_results.search("#flightmatrix_row :nth-child(2) .sortkey").map(&:text).map(&:strip)
		  j = departs_array.length - 1
		  #AirTran appears to have a bug where it sometimes adds 12 hours to an afternoon departure
		  #This block corrects that error
		  for i in (0..j)
			  departs_array[i] = departs_array[i].to_i
		  	if departs_array[i] >= 2400
				  departs_array[i] -= 1200
			  end
		  end
      
      for i in (0..j)
        if departs_array[i] < 1000
          departs_array[i] = "0"+departs_array[i].to_s
        else
          departs_array[i] = departs_array[i].to_s
        end
      end

		  arrives_array = printable_results.search(":nth-child(3) .sortkey").map(&:text).map(&:strip)
		  duration_array = printable_results.search("td:nth-child(4) .sortkey").map(&:text).map(&:strip)

		#Scrape flight number and flight dates simultaneously
		@flight_array = printable_results.search(".selectsub span , #flightmatrix_row td:nth-child(1)").map(&:text).map(&:strip)

		#The flight number scrape also picks up seats remaining, so all of those objects are cleaned from the array
		@flight_array.delete_if {|x| x == "" || x.include?("seat") }

		#Split up flight number and flight date arrays 
		@all_date_array = @flight_array[0,5]
		@flight_array.slice!(0,5)
		j = @flight_array.length-1

		#Clean flight number array
		for i in (0..j)
			a = @flight_array[i]
			@flight_array[i] = a[0,3]
		end

		#Create new array that matches date of each flight
		#Switches to next date if departure time rolls over to next day
		@date_array = Array.new
		j = departs_array.length-1
		day_we_are_on = 0
		for k in (0..j)
			if k == 0
				@date_array[k] = @all_date_array[k]
			elsif departs_array[k] < departs_array[k-1]
				day_we_are_on += 1
				@date_array[k] = @all_date_array[day_we_are_on]
			else
				@date_array[k] = @all_date_array[day_we_are_on]
			end
			@date_array[k].slice!("Flights on ")
			@date_array[k] = @date_array[k].gsub(/\,/,"")
      @date_array[k] = Date.strptime(@date_array[k], fmt='%a %B %d %Y')
		end

		#Create output array of each flight record
		  output = Array.new
		  for i in (0..j)
        if nonstop_array[i].to_s == "nonstop"
			    Flight.create(:airline => "AT", :observation_date => Time.now.ctime, :flight_date => @date_array[i], :origin => @fromCity, :destination => @toCity, :price => price_array[i], :flight_number => @flight_array[i], :departs => ((departs_array[i])[0..1]+":"+(departs_array[i])[2..3]), :arrives => (arrives_array[i][0..1]+":"+arrives_array[i][2..3]), :duration => duration_array[i], :seats => cleaned_seats_array[i])
        end
      end
	end   
end

class FlightsController < ApplicationController  
  
  def index
    @title = "Search Flights"
    flight_date = Date.strptime(params[:flight_date], fmt='%m/%d/%Y')    
                                                  
    @flights = Flight.find_by_sql(" SELECT DISTINCT flights.flight_date, flights.flight_number, 
                                    flights.origin, flights.destination, flights.airline FROM flights
                                    WHERE flight_date = '#{flight_date}'
                                    AND origin = '#{params[:origin]}' 
                                    AND destination = '#{params[:destination]}'
                                    AND airline = '#{params[:airline]}'")                                                  
  end
  
  def show
    @title = "Flight History"
    
    referenceFlight = Flight.find(params[:id])
    @flights = Flight.find(:all, :conditions => { :origin => referenceFlight.origin,
                                                :destination => referenceFlight.destination,
                                                :flight_date => referenceFlight.flight_date,
                                                :flight_number => referenceFlight.flight_number,
                                                :airline => referenceFlight.airline
                                                  })
    @chartseries = ""
    @flights.each do |f|
      @chartseries << "[#{((Time.now.to_f - f.observation_date.to_f)/86400).round(2)},#{f.price}],"
    end
  end  
  
end

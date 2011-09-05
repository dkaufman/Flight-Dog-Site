class FlightsController < ApplicationController  
  
  def index
    @title = "Search Flights"
    flight_date = Date.strptime(params[:flight_date], fmt='%m/%d/%Y')    
                                                  
    @flights = Flight.find_by_sql(" SELECT DISTINCT flights.flight_date, flights.departs, 
                                    flights.origin, flights.destination FROM flights
                                    WHERE flight_date = '#{flight_date}'
                                    AND origin = '#{params[:origin]}' AND destination = '#{params[:destination]}'")                                                  
  end
  
  def show
    @title = "Flight History"
    
    referenceFlight = Flight.find(params[:id])
    @flights = Flight.find(:all, :conditions => { :origin => referenceFlight.origin,
                                                :destination => referenceFlight.destination,
                                                :flight_date => referenceFlight.flight_date,
                                                :departs => referenceFlight.departs
                                                  })
    @series = ""  
    @flights.each do |f|
      @series << "[#{f.observation_date.to_i*1000},#{f.price}],"
    end
    @series.chop
  end  
  
end

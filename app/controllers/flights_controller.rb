class FlightsController < ApplicationController  
  
  def index
    @title = "Search Flights"
    flightDate = Date.strptime(params[:flightDate], fmt='%m/%d/%Y')    
                                                  
    @flights = Flight.find_by_sql(" SELECT DISTINCT flightDate, departs, origin, destination FROM flights
                                    WHERE flightDate = '#{flightDate}'
                                    AND origin = '#{params[:origin]}' AND destination = '#{params[:destination]}'")                                                  
  end
  
  def show
    @title = "Flight History"
    
    referenceFlight = Flight.find(params[:id])
    @flights = Flight.find(:all, :conditions => { :origin => referenceFlight.origin,
                                                :destination => referenceFlight.destination,
                                                :flightDate => referenceFlight.flightDate,
                                                :departs => referenceFlight.departs
                                                  })
    @series = ""  
    @flights.each do |f|
      @series << "[#{f.observationDate.to_i*1000},#{f.price}],"
    end
    @series.chop
  end  
  
end

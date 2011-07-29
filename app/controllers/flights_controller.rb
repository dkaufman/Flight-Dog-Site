class FlightsController < ApplicationController
  def index
    @title = "Search Flights"
    flightYear = params[:flightDate]["year"]
    flightMonth = params[:flightDate]["month"]
    flightDay = params[:flightDate]["day"]
    flightDate = Date.new(flightYear.to_i, flightMonth.to_i, flightDay.to_i)
    flightDeparts = Time.utc(2000, "jan", 1, params[:departs]["hour"], params[:departs]["minute"])

    
            @flights = Flight.find(:all, :conditions => { :origin => params[:origin],
                                                  :destination => params[:destination],
                                                  :flightDate => flightDate,
                                                  :departs => flightDeparts
                                                  }).paginate(:page => params[:page])
  
  end
end

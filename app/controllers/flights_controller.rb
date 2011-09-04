class FlightsController < ApplicationController  
  
  def index
    @title = "Search Flights"
    flightDate = Date.strptime(params[:flightDate], fmt='%m/%d/%Y')
    @flights = Flight.find(:all, :conditions => { :origin => params[:origin],
                                                :destination => params[:destination],
                                                :flightDate => flightDate
                                                #:airline => params[:airline]
                                                  }, :group => 'departs')
                                                  
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
    
  
  def list
    list = []
    flights = Flight.where("airline like ?", "%#{params[:term]}%").limit(10)
    flights.each { |flight| list << { "label" => flight.airline } }
    
    respond_to do |format|
      format.json { render :json => list.to_json, :layout => false }
    end
  end  
end

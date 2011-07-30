# == Schema Information
#
# Table name: flights
#
#  id              :integer         not null, primary key
#  observationDate :datetime
#  flightDate      :date
#  origin          :string(255)
#  destination     :string(255)
#  price           :float
#  flightNumber    :string(255)
#  departs         :time
#  arrives         :time
#  duration        :integer
#  seats           :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Flight < ActiveRecord::Base
  
  attr_protected  :id, :observationDate, :flightDate, :origin, :destination, :price, :flightNumber,
                  :departs, :arrives, :duration, :seats, :created_at, :updated_at
  
  AIRPORTS = ["BOS", "BWI"]
  
  def readonly?
    return false
  end
    
end

# == Schema Information
#
# Table name: flights
#
#  id              :integer         not null, primary key
#  observation_date :datetime
#  flight_date      :date
#  origin          :string(255)
#  destination     :string(255)
#  price           :float
#  flight_number    :string(255)
#  departs         :time
#  arrives         :time
#  duration        :integer
#  seats           :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Flight < ActiveRecord::Base
  
  attr_accessible  :id, :observation_date, :flight_date, :origin, :destination, :price, :flight_number,
                  :departs, :arrives, :duration, :seats, :created_at, :updated_at, :airline
  
  AIRPORTS = ["BOS", "BWI"]
  
  def readonly?
    return false
  end
    
end

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

require 'test_helper'

class FlightTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

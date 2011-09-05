class ColumnsToLowercase < ActiveRecord::Migration
  def self.up
    rename_column :flights, :flightDate, :flight_date
    rename_column :flights, :flightNumber, :flight_number
    rename_column :flights, :observationDate, :observation_date
  end

  def self.down
    rename_column :flights, :flight_date, :flightDate
    rename_column :flights, :flight_number, :flightNumber
    rename_column :flights, :observation_date, :observationDate
  end
end

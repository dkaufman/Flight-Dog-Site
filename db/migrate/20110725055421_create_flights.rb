class CreateFlights < ActiveRecord::Migration
  def self.up
    create_table :flights do |t|
      t.datetime :observationDate
      t.date :flightDate
      t.string :origin
      t.string :destination
      t.float :price
      t.string :flightNumber
      t.time :departs
      t.time :arrives
      t.integer :duration
      t.integer :seats

      t.timestamps
    end
  end

  def self.down
    drop_table :flights
  end
end

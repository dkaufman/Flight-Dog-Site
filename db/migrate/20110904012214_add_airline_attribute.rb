class AddAirlineAttribute < ActiveRecord::Migration
  def self.up
    add_column :flights, :airline, :string
  end

  def self.down
    remove_column :flights, :airline
  end
end

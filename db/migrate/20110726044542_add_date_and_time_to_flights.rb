class AddDateAndTimeToFlights < ActiveRecord::Migration
  def self.up
    add_column :flights, :departsHour, :integer
    add_column :flights, :departsMinute, :integer
    add_column :flights, :arrivesHour, :integer
    add_column :flights, :arrivesMinute, :integer
  end

  def self.down
    remove_column :flights, :departsHour
    remove_column :flights, :departsMinute
    remove_column :flights, :arrivesHour
    remove_column :flights, :arrivesMinute
  end
end

class AddOriginIndex < ActiveRecord::Migration
  def self.up
    add_index :flights, :origin
  end

  def self.down
    remove_index :flights, :origin
  end
end

class RemoveCommentsTable < ActiveRecord::Migration
  def self.up
    drop_table :comments
  end
end

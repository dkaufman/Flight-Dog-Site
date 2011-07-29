# == Schema Information
#
# Table name: suggestions
#
#  id         :integer         not null, primary key
#  email      :string(255)
#  content    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Suggestion < ActiveRecord::Base
  attr_accessible :email, :content
  
  validates :email, :presence => true
  validates :content, :presence => true
end

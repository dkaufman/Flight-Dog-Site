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

require 'test_helper'

class SuggestionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

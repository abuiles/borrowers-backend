require 'test_helper'

class FriendTest < ActiveSupport::TestCase
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:email)
  should validate_presence_of(:twitter)

  should have_many(:articles)
end

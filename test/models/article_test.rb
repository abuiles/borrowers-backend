require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  should validate_presence_of(:description)
  should validate_presence_of(:state)

  should belong_to(:friend)
  should validate_inclusion_of(:state).
    in_array(%w(borrowed returned))
end

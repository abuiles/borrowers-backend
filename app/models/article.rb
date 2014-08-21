class Article < ActiveRecord::Base
  belongs_to :friend

  validates :description, presence: true
  validates :state, presence: true, inclusion: { in: %w(borrowed returned) }
end

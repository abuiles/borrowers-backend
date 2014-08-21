class Friend < ActiveRecord::Base
  has_many :articles

  validates :first_name, presence: true
  validates :last_name , presence: true
  validates :twitter   , presence: true
  validates :email     , presence: true
end

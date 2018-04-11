class Checkout < ActiveRecord::Base
  belongs_to :user
  has_many :ads
end

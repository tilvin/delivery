class Restaurant < ApplicationRecord

  has_many :users
  has_many :orders
  has_many :points

  validates :name, presence: true

end

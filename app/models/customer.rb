class Customer < ApplicationRecord
  validates :firstname, :lastname, :email, presence: true
  validates :email, uniqueness: true
  has_many :orders
  has_many :ratings
  has_secure_password
end

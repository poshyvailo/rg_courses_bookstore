class Customer < ApplicationRecord
  validates :firstname, :lastname, :email, presence: true
  validates :email, uniqueness: true, format: {
      with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  }
  has_many :orders
  has_many :ratings
  has_secure_password
end

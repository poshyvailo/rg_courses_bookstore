class CreditCard < ApplicationRecord
  validates :firstname, :lastname, :number, :cvv,
            :expiration_month, :expiration_year, presence: true
  belongs_to :customer
  has_many :order
end

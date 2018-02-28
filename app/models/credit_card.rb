class CreditCard < ApplicationRecord
  validates :firstname, :number, :cvv, :expiration_month, presence: true
end

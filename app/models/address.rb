class Address < ApplicationRecord
  validates :firstname, :lastname, :delivery_address, :zipcode, :city, :country, :phone, presence: true
end

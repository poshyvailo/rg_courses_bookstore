class Address < ApplicationRecord
  validates :address, :zipcode, :city, :phone, presence: true
  belongs_to :addressable, polymorphic: true
  belongs_to :country
end

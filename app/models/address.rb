class Address < ApplicationRecord
  validates :firstname, :lastname, :delivery_address, :zipcode, :city, :country, :phone, presence: true

  validates :firstname, :lastname, :country,
            format: { with: /\A[a-zA-Z\-]+\z/ }
  validates :firstname, :lastname, :delivery_address, :country, :city,
            length: { maximum: 50 }

  validates :delivery_address, format: { with: /\A[a-zA-Z0-9\-\,\.\s]+\z/ }

  validates :zipcode, format: { with: /\A[0-9\-]+\z/ }, length: { maximum: 10 }
end

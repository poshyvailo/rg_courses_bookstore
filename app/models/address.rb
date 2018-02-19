class Address < ApplicationRecord
  validates :firstname, :lastname, :address, :zipcode, :city, :country, :phone, presence: true
  has_one :billable_orders, class_name: 'Customer', foreign_key: 'billing_address_id'
  has_one :shippable_orders, class_name: 'Customer', foreign_key: 'shipping_address_id'
end

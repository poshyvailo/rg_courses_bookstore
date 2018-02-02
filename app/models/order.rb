class Order < ApplicationRecord
  validates :total_price, :completed_date, :state, presence: true
  belongs_to :customer
  belongs_to :credit_card
  has_many :order_items

  has_one :billing_address, class_name: 'Address', as: :addressable
  has_one :shipping_address, class_name: 'Address', as: :addressable
end

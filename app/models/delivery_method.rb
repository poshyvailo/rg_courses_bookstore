class DeliveryMethod < ApplicationRecord
  validates :name, :shipping_days, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :name, :shipping_days, length: { maximum: 50 }
end
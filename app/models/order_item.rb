class OrderItem < ApplicationRecord
  validates :price, :quantity, presence: true

  validates :price, numericality: { greater_than: 0 }
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :book
  belongs_to :order
end

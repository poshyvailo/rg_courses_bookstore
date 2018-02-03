class Order < ApplicationRecord
  include AASM

  aasm :column => :state do
    state :in_progress, initial: true
    state :complited
    state :shipped

    event :complited do
      transitions from: [:in_progress], to: :complited
    end

    event :shipped do
      transitions from: [:complited], to: :shipped
    end
  end

  validates :total_price, :completed_date, :state, presence: true
  belongs_to :customer
  belongs_to :credit_card
  has_many :order_items

  has_one :billing_address, class_name: 'Address', as: :addressable
  has_one :shipping_address, class_name: 'Address', as: :addressable
end

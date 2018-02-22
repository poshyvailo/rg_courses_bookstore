class Order < ApplicationRecord
  include AASM

  aasm :column => :state do
    state :in_progress, initial: true
    state :complited
    state :shipped

    event(:complited) { transitions from: [:in_progress], to: :complited }
    event(:shipped) { transitions from: [:complited], to: :shipped }
  end

  belongs_to :customer,  optional: true
  belongs_to :credit_card, optional: true
  has_many :order_items
  has_one :billing_address, class_name: 'Address', as: :addressable
  has_one :shipping_address, class_name: 'Address', as: :addressable
end

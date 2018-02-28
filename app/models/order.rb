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
  has_many :order_items, dependent: :delete_all

  belongs_to :delivery_method
  belongs_to :credit_card, optional: true

  belongs_to :billing_address, class_name: 'Address', optional: true
  belongs_to :shipping_address, class_name: 'Address', optional: true

  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :credit_card

  def billing_address
    super() || build_billing_address
  end

  def shipping_address
    super() || build_shipping_address
  end

  def credit_card
    super() || build_credit_card
  end
end

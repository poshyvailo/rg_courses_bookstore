class Order < ApplicationRecord
  include AASM

  aasm :column => :state do
    state :in_progress, initial: true
    state :completed
    state :shipped

    event(:completed) { transitions from: [:in_progress], to: :completed }
    event(:shipped) { transitions from: [:completed], to: :shipped }
  end

  has_many :order_items, dependent: :delete_all

  belongs_to :customer, optional: true
  belongs_to :delivery_method, optional: true
  belongs_to :credit_card, optional: true
  belongs_to :coupon, optional: true

  belongs_to :billing_address, class_name: 'Address', optional: true
  belongs_to :shipping_address, class_name: 'Address', optional: true

  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :credit_card

  scope :in_progress, -> { where(state: :in_progress) }

  %w[billing_address shipping_address credit_card].each do |method|
    define_method method.to_sym do
      super() || public_send("build_#{method}")
    end
  end
end

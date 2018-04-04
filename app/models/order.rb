class Order < ApplicationRecord
  include AASM

  aasm :column => :state do
    state :in_progress, initial: true
    state :waiting_for_processing
    state :in_delivery
    state :delivered
    state :canceled

    event(:waiting_for_processing) { transitions from: :in_progress, to: :waiting_for_processing }
    event(:in_delivery) { transitions from: :waiting_for_processing, to: :in_delivery }
    event(:delivered) { transitions from: :in_delivery, to: :delivered }
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
  scope :not_in_progress, -> { where.not(state: :in_progress) }
  scope :find_book, -> (book) { not_in_progress.includes(:order_items).where("order_items.book" => book) }

  %w[billing_address shipping_address credit_card].each do |method|
    define_method method.to_sym do
      super() || public_send("build_#{method}")
    end
  end
end

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

  belongs_to :billing_address, class_name: 'Address', optional: true
  belongs_to :shipping_address, class_name: 'Address', optional: true

  # validates :billing_address, :presence => true, if: :confirm_or_address?
  # validates :shipping_address, :presence => true, if: :confirm_or_address?
  validates :delivery_method, :presence => true, if: :confirm_or_delivery?
  # validates :credit_card, :presence => true, if: :confirm_or_payment?
  # validates :customer, :presence => true,  if: :confirm?

  accepts_nested_attributes_for :shipping_address, :billing_address, :credit_card

  scope :in_progress, -> { where(state: :in_progress) }

  def confirm?
    order_step == 'complete'
  end

  #
  # def confirm_or_address?
  #   order_step == 'address' || confirm?
  # end
  #
  def confirm_or_delivery?
    order_step == 'delivery' || confirm?
  end
  #
  # def confirm_or_payment?
  #   order_step == 'payment' || confirm?
  # end

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

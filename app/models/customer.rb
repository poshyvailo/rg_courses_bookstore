class Customer < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable

  has_many :orders
  has_many :ratings

  belongs_to :billing_address, class_name: 'Address', optional: true
  belongs_to :shipping_address, class_name: 'Address', optional: true

  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address

  def billing_address
    super() || build_billing_address
  end

  def shipping_address
    super() || build_shipping_address
  end

end

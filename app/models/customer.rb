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

  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'

  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address

  %i(billing_address shipping_address).each do |field|
    define_method(field) do
      super() || send("build_#{field}")
    end
  end

end

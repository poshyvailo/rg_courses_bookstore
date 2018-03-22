class Coupon < ApplicationRecord
  validates :name, :discount, :available, presence: true

  scope :available, -> { where available: true }

end

class Coupon < ApplicationRecord
  validates :name,
            :discount,
            :available,
            presence: true

  validates :discount, numericality: { greater_than: 0 }

  scope :available, -> { where available: true }

end

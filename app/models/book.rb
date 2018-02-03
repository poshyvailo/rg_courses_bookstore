class Book < ApplicationRecord
  validates :title, presence: true

  validates :price,
            presence: true,
            numericality: true

  validates :in_stock,
            presence: true,
            numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0,
                allow_nil: true
            }

  belongs_to :category
  belongs_to :author
  has_many :rating
end

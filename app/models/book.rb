class Book < ApplicationRecord

  has_many :books_author, dependent: :destroy
  has_many :authors, through: :books_author

  has_many :books_category, dependent: :destroy
  has_many :categories, through: :books_category

  has_many :rating

  validates :title, presence: true

  validates :price, presence: true, numericality: true

  validates :height, :width, :depth, numericality: true

  validates :in_stock, presence: true,
            numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0,
                allow_nil: true
            }

  scope :created_asc, -> { order(created_at: :asc) }
  scope :created_desc, -> { order(created_at: :desc) }
  scope :price_asc, -> { order(price: :asc) }
  scope :price_desc, -> { order(price: :desc) }
end

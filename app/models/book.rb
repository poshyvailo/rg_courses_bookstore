class Book < ApplicationRecord
  include Sortable

  mount_uploader :image, ImageUploader

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

  scope :price_sort, -> (value) { order(price: value) }
  scope :created_sort, -> (value) { order(created_at: value) }
  scope :slider, -> { order(created_at: :desc).includes(:authors).limit(3) }
  scope :best_seller, -> { order("RANDOM()").includes(:authors).limit(4) }
end

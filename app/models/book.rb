class Book < ApplicationRecord
  include Sortable

  mount_uploader :image, ImageUploader

  has_many :books_author, dependent: :destroy
  has_many :authors, through: :books_author

  has_many :books_category, dependent: :destroy
  has_many :categories, through: :books_category

  has_many :reviews

  validates :title,
            :price,
            :in_stock,
            presence: true

  validates :price,
            :height,
            :width,
            :depth,
            numericality: { greater_than: 0 }

  validates :in_stock,
            numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0,
            }

  scope :price_sort, -> (value) { order(price: value) }
  scope :created_sort, -> (value) { order(created_at: value) }
  scope :title_sort, -> (value) { order(title: value) }
  scope :slider, -> { created_sort(:desc).includes(:authors).limit(3) }
  scope :best_seller, -> { order("RANDOM()").includes(:authors).limit(4) }
end

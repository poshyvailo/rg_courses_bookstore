class Category < ApplicationRecord

  has_many :books_category, dependent: :destroy
  has_many :books, through: :books_category

  validates :title, presence: true, uniqueness: true
end

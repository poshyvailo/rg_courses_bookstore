class BooksCategory < ApplicationRecord
  belongs_to :book
  belongs_to :category

  validates :book, presence: true
  validates :category, presence: true
end
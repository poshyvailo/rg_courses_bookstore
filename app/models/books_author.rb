class BooksAuthor < ApplicationRecord
  belongs_to :book
  belongs_to :author

  validates :book, presence: true
  validates :author, presence: true
end
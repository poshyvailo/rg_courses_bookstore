class Author < ApplicationRecord
  validates :firstname, :lastname, presence: true

  has_many :books_author, dependent: :destroy
  has_many :authors, through: :books_author
end

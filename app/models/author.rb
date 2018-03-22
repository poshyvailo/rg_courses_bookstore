class Author < ApplicationRecord
  validates :firstname, :lastname, presence: true

  validates :firstname,
            :lastname,
            format: { with: /\A[a-zA-Z\-]+\z/ },
            length: { maximum: 50 }

  validates :biography, length: { maximum: 1000 }

  has_many :books_author, dependent: :destroy
  has_many :authors, through: :books_author
end

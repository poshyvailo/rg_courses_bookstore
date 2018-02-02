class Book < ApplicationRecord
  validates :title, :price, :in_stock, presence: true
  belongs_to :category
  belongs_to :author
  has_many :rating
end

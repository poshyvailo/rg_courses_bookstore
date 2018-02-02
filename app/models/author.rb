class Author < ApplicationRecord
  validates :firstname, :lastname, presence: true
  has_many :books
end

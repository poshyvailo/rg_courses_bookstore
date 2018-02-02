class Rating < ApplicationRecord
  validates :text_review, :rating_number, presence: true
  belongs_to :book
  belongs_to :customer
end

class Rating < ApplicationRecord
  validates :text_review, presence: true

  validates :rating_number,
            presence: true,
            numericality: {
                only_integer: true,
                greater_than_or_equal_to: 1,
                less_than_or_equal_to: 10
            }

  belongs_to :book
  belongs_to :customer
end

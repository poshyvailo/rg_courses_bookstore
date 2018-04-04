class Review < ApplicationRecord

  before_save :set_verified

  validates :text_review, presence: true

  validates :firstname,
            :lastname,
            presence: true,
            format: { with: /\A[a-zA-Z\-]+\z/ }

  validates :rating_number,
            presence: true,
            numericality: {
                only_integer: true,
                greater_than_or_equal_to: 1,
                less_than_or_equal_to: 5
            }

  belongs_to :book
  belongs_to :customer

  def set_verified
    self.verified = customer.orders.find_book(book).empty? ? false : true
  end
end

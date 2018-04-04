class ReviewsController < ApplicationController

  load_and_authorize_resource :book

  def create
    review = current_customer.reviews.new(review_params.merge(book: @book))
    if review.valid?
      review.save
      redirect_to catalog_book_path(@book), notice: 'Review added'
    else
      redirect_to catalog_book_path(@book), alert: review.errors.full_messages
    end
  end

  private

  def review_params
    params.require(:review).permit(:firstname, :lastname, :rating_number, :text_review)
  end

end
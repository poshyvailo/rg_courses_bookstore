class BookController  < ApplicationController
  load_and_authorize_resource :book
  decorates_assigned :book
  decorates_assigned :review

  def show
    @reviews = @book.reviews.decorate
    @book = @book.decorate
  end

  def update

  end
end
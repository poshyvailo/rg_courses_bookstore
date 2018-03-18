class BookController  < ApplicationController
  load_and_authorize_resource :book
  decorates_assigned :book

  def show
    @book = @book.decorate
  end
end
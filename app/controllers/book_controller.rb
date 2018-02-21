class BookController  < ApplicationController

  decorates_assigned :book

  def show
    @book = Book.find(params[:id]).decorate
  end
end
class CatalogsController < ApplicationController

  decorates_assigned :book

  def show
    @books = Book.page(params[:page]).decorate
    # source = Book.all.decorate
    # @books = BookDecorator.new(source)
  end
end
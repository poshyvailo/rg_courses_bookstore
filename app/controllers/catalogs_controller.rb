class CatalogsController < ApplicationController

  decorates_assigned :book

  def show
    @books = Book.all.decorate
    # source = Book.all.decorate
    # @books = BookDecorator.new(source)
  end
end
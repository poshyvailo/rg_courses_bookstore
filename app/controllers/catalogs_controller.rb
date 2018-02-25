class CatalogsController < ApplicationController

  decorates_assigned :book

  def show
    @books = Book.sorting(params.slice(:price_sort, :created_sort)).page(params[:page]).decorate
  end
end
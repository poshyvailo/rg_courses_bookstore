class CategoryController < ApplicationController
  def show
    @books = Category.find(params[:id]).books.includes(:authors).sorting(params.slice(:price_sort, :created_sort)).page(params[:page]).decorate
  end
end
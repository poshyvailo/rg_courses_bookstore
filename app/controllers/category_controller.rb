class CategoryController < ApplicationController
  def show
    @books = Category.find(params[:id]).books.page(params[:page]).decorate
  end
end
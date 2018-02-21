class CategoryController < ApplicationController
  def show
    @books = Category.find(params[:id]).books
  end
end
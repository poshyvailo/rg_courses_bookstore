class MainController < ApplicationController
  def home
    @carousel = Book.created_desc.limit(3).decorate
    @bestseller = Book.order("RANDOM()").limit(4).decorate
  end
end
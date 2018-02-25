class MainController < ApplicationController
  def home
    @carousel = Book.order(created_at: :desc).limit(3).decorate
    @bestseller = Book.order("RANDOM()").limit(4).decorate
  end
end
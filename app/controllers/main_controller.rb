class MainController < ApplicationController
  def home
    @carousel = Book.slider.decorate
    @bestseller = Book.best_seller.decorate
  end
end
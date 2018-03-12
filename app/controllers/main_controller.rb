class MainController < ApplicationController
  def home
    @carousel = Book.order(created_at: :desc).includes(:authors).limit(3).decorate
    @bestseller = Book.order("RANDOM()").includes(:authors).limit(4).decorate
  end
end
class CartsController < ApplicationController
  def show
    @order = current_order.decorate
  end
end
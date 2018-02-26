class CartsController < ApplicationController

  include OrderOperation

  def show
    @order = current_order.decorate
  end
end
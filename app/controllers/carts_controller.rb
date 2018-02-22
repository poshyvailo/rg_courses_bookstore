class CartsController < ApplicationController
  def show
    order_id = cookies.encrypted[:order_id]
    @items = Order.find(order_id).order_items
  end
end
class CartsController < ApplicationController
  def show
    @order = current_order.decorate
  end

  def update
    coupon = Coupon.find_by name: params[:coupon]
  end
end
class CartsController < ApplicationController

  before_action :load_order

  def show; end

  def update
    coupon = Coupon.find_by name: params[:coupon].upcase

    if coupon.nil?
      redirect_to cart_path, alert: t('cart.msg.coupon_not_found') if coupon.nil?
    else
      if coupon.available?
        @order.update(coupon: coupon)
        redirect_to cart_path, notice: t('cart.msg.coupon_added')
      else
        redirect_to cart_path, alert: t('cart.msg.coupon_used')
      end
    end
  end

  private

  def load_order
    @order = current_order.decorate
  end

end
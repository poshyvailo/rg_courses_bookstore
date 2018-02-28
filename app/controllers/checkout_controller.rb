class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm, :complete

  def update
    @order = current_order
    case step
      when :address
        copy_billing_to_shipping if params[:use_billing_address]
        @order.update order_address_params
      when :delivery
        @delivery_methods = DeliveryMethod.all
        @order.update order_delivery_params
      when :payment
        @order.update order_payment_params
    end
    render_wizard @order
  end

  def show
    @order = current_order
    case step
      when :delivery
        @delivery_methods = DeliveryMethod.all
    end
    render_wizard
  end

  private

  def order_address_params
    params.require(:order).permit(
        billing_address_attributes: [:firstname, :lastname, :address, :zipcode, :city, :phone, :country, :id],
        shipping_address_attributes: [:firstname, :lastname, :address, :zipcode, :city, :phone, :country, :id]
    )
  end

  def order_delivery_params
    params.require(:order).permit(:delivery_method_id)
  end

  def order_payment_params
    params.require(:order).permit(credit_card_attributes: [:firstname, :number, :cvv, :expiration_month])
  end

  def copy_billing_to_shipping
    params[:order][:shipping_address_attributes] = params[:order][:billing_address_attributes]
  end
end
class CheckoutController < ApplicationController
  include Wicked::Wizard
  include CheckoutOperation

  steps :address, :delivery, :payment, :confirm

  def update
    @order = current_order
    set_order_step unless confirm_step?

    case step
      when :address
        copy_billing_to_shipping if params[:use_billing_address]
      when :delivery
        @delivery_methods = DeliveryMethod.all
    end
    @order.update(order_params)
    confirm_step? ? (redirect_to wizard_path(:confirm)) : render_wizard(@order)
  end

  def show
    @order = current_order
    unless order_step == 'payment'
      if next_order_step != step
        jump_to(next_order_step)
      end
    end

    case step
      when :delivery
        @delivery_methods = DeliveryMethod.all
    end
    render_wizard
  end

  private

  def order_params
    params.require(:order).permit(
        :order_step,
        :delivery_method_id,
        billing_address_attributes: [:firstname, :lastname, :address, :zipcode, :city, :phone, :country, :id],
        shipping_address_attributes: [:firstname, :lastname, :address, :zipcode, :city, :phone, :country, :id],
        credit_card_attributes: [:firstname, :number, :cvv, :expiration_month],
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
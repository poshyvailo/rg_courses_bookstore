class CheckoutController < ApplicationController
  include Wicked::Wizard
  include CheckoutOperation

  before_action :authenticate_customer!

  steps :address, :delivery, :payment, :confirm

  def update
    @order = current_order

    set_order_step unless confirm_step?

    if address_step?
      copy_billing_to_shipping if use_billing_address?
    end

    load_delivery_methods if delivery_step?

    @order.update(order_params)

    if @order.valid? && confirm_step?
      redirect_to wizard_path(:confirm)
    else
      render_wizard(@order)
    end
  end

  def show
    @order = current_order

    unless confirm_step?
      jump_to(next_order_step) if next_order_step != step
    end

    load_delivery_methods if delivery_step?

    render_wizard
  end

  private

  def load_delivery_methods
    @delivery_methods = DeliveryMethod.all
  end

  def order_params
    params.require(:order).permit(:order_step,
        :delivery_method_id, :customer_id,
        billing_address_attributes: address_attributes,
        shipping_address_attributes: address_attributes,
        credit_card_attributes: credit_card_attributes)
  end

  def address_attributes
    %i[firstname lastname address zipcode city phone country id]
  end

  def credit_card_attributes
    %i[firstname number cvv expiration_month]
  end

  def order_delivery_params
    params.require(:order).permit(:delivery_method_id)
  end

  def order_payment_params
    params.require(:order).permit(credit_card_attributes: [:firstname, :number, :cvv, :expiration_month])
  end

end
class CheckoutController < ApplicationController
  include Wicked::Wizard
  include CheckoutOperation

  before_action :authenticate_customer!

  steps :address, :delivery, :payment, :confirm

  def update
    @order = current_order.decorate

    set_order_step

    if address_step?
      copy_billing_to_shipping if use_billing_address?
    end

    if confirm_step?
      complete_order
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
    @order = current_order.decorate

    unless params[:id] == 'wicked_finish'
      unless confirm_step? && order_step != 'complete'
        logger.debug "REDIRECT FROM SHOW"
        logger.debug "#{confirm_step?}"
        logger.debug "#{order_step == 'complete'}"
        jump_to(next_order_step) if next_order_step != step
      end
    end

    load_delivery_methods if delivery_step?

    render_wizard
  end

  private

  def complete_order
    params[:order][:state] = :completed
    cookies.delete :order_id
  end

  def finish_wizard_path
    root_path
  end

  def load_delivery_methods
    @delivery_methods = DeliveryMethod.all
  end

  def order_params
    params.require(:order).permit(:order_step,
        :delivery_method_id, :customer_id, :state,
        billing_address_attributes: address_attributes,
        shipping_address_attributes: address_attributes,
        credit_card_attributes: credit_card_attributes)
  end

  def address_attributes
    %i[firstname lastname delivery_address zipcode city phone country id]
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
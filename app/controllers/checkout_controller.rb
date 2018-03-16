class CheckoutController < ApplicationController
  include Wicked::Wizard
  include CheckoutOperation

  before_action :authenticate_customer!

  steps :address, :delivery, :payment, :confirm, :complete

  def update
    @order = Order.find(params[:order_id]).decorate

    set_order_step if step == next_order_step

    if current_step_address?
      copy_billing_to_shipping if use_billing_address?
    end

    complete_order if step == :confirm

    load_delivery_methods if current_step_delivery?
    @order.update(order_params)

    if @order.valid? && next_order_step_confirm?
      redirect_to wizard_path(:confirm)
    else
      render_wizard(@order)
    end
  end

  def show
    @order = Order.find(params[:order_id]).decorate

    unless params[:id] == 'wicked_finish'
      unless next_order_step_confirm? && order_step != 'complete'
        jump_to(next_order_step) if next_order_step != step
      end
    end

    if current_step_address?
      unless @order.billing_address_id
        # @order.billing_address.destroy
        @order.billing_address = current_customer.billing_address.dup
      end
      unless @order.shipping_address_id
        # @order.shipping_address.destroy
        @order.shipping_address = current_customer.shipping_address.dup
      end
    end

    load_delivery_methods if current_step_delivery?
    render_wizard
  end

  private

  def order_step
    @order.order_step
  end

  def set_order_step
    params[:order] ||= {}
    params[:order][:order_step] = step
  end

  def complete_order
    params[:order][:completed_date] = Time.now.to_date
    params[:order][:total_price] = @order.total
    params[:order][:state] = :completed
    cookies.delete :order_id
  end

  def copy_billing_to_shipping
    params[:order][:shipping_address_attributes] =params[:order][:billing_address_attributes]
  end

  def use_billing_address?
    params[:use_billing_address]
  end

  def load_delivery_methods
    @delivery_methods = DeliveryMethod.all
  end

  def order_params
    params.require(:order).permit(:order_step,
                                  :delivery_method_id, :customer_id, :state, :completed_date, :total_price,
                                  billing_address_attributes: address_attributes,
                                  shipping_address_attributes: address_attributes,
                                  credit_card_attributes: credit_card_attributes)
  end

  def address_attributes
    %i[id firstname lastname delivery_address zipcode city phone country]
  end

  def credit_card_attributes
    %i[id card_owner number cvv expiration]
  end

end
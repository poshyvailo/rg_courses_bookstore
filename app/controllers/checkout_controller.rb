class CheckoutController < ApplicationController
  include Wicked::Wizard
  include CheckoutOperation

  load_and_authorize_resource :order

  before_action :load_order
  before_action :authenticate_customer!
  before_action :step_permission, only: :show

  steps :address, :delivery, :payment, :confirm, :complete

  def update
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
    if current_step_address?
      unless @order.billing_address_id
        @order.billing_address = current_customer.billing_address.dup
      end
      unless @order.shipping_address_id
        @order.shipping_address = current_customer.shipping_address.dup
      end
    end

    load_delivery_methods if current_step_delivery?
    render_wizard
  end

  private

  def load_order
    @order = @order.decorate
  end

  def step_permission
    # unless params[:id] == 'wicked_finish'
    #   unless next_order_step_confirm? && params[:id] != 'complete'
    #     jump_to(next_order_step) if next_order_step != step
    #   end
    # end

    if @order.billing_address_id.nil? && step != :address
      jump_to(:address)
    end

    if !@order.billing_address_id.nil? && @order.delivery_method_id.nil? && step != :delivery
      jump_to(:delivery)
    end

    if !@order.billing_address_id.nil? && !@order.delivery_method_id.nil? && @order.credit_card_id.nil? && step != :payment
      jump_to(:payment)
    end

    if !@order.billing_address_id.nil? && !@order.delivery_method_id.nil? && !@order.credit_card_id.nil? && !@order.completed? && step != :confirm
      jump_to(:confirm)
    end

    if @order.completed? && step != :complete
      jump_to(:complete)
    end

  end

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
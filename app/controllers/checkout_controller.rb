class CheckoutController < ApplicationController
  include Wicked::Wizard

  load_and_authorize_resource :order

  STEP_ACCESS = {
      complete: %i[complete],
      confirm: %i[confirm address delivery payment],
      payment: %i[payment],
      delivery: %i[delivery],
      address: %i[address]
  }

  before_action :authenticate_customer!
  before_action :load_order
  before_action :load_params
  before_action :step_permission, only: :show

  steps :address, :delivery, :payment, :confirm, :complete

  def update
    case step
      when :address; use_billing_address
      when :delivery; load_delivery_methods
      when :confirm; complete_order
    end

    @order.update(order_params)

    if @order.valid? && current_step == :confirm
      redirect_to wizard_path(:confirm)
    else
      render_wizard(@order)
    end
  end

  def show
    case step
      when :address; load_customer_addresses
      when :delivery; load_delivery_methods
    end
    render_wizard
  end

  private

  def load_order
    @order = @order.decorate
  end

  def load_params
    @params = params[:order] || ActionController::Parameters.new
  end

  def step_permission
    jump_to(current_step) unless STEP_ACCESS[current_step].include? step
  end

  def current_step
    s = :complete
    s = :confirm unless @order.waiting_for_processing?
    s = :payment if @order.credit_card_id.nil?
    s = :delivery if @order.delivery_method_id.nil?
    s = :address if @order.object.billing_address_id.nil? || @order.object.shipping_address_id.nil?
    s
  end

  def load_customer_addresses
    %w[billing shipping].each do |address_type|
      unless @order.public_send("#{address_type}_address_id")
        value = current_customer.public_send("#{address_type}_address").dup
        @order.public_send("#{address_type}_address=", value)
      end
    end
  end

  def complete_order
    @params[:completed_date] = Time.now.to_date
    @params[:total_price] = @order.total
    @params[:state] = :waiting_for_processing
    cookies.delete :order_id
  end

  def copy_billing_to_shipping
    @params[:shipping_address_attributes] = @params[:billing_address_attributes]
  end

  def use_billing_address?
    params[:use_billing_address]
  end

  def use_billing_address
    copy_billing_to_shipping if use_billing_address?
  end

  def load_delivery_methods
    @delivery_methods = DeliveryMethod.all
  end

  def order_params
    @params.permit(:order_step,
                   :delivery_method_id,
                   :customer_id,
                   :state,
                   :completed_date,
                   :total_price,
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
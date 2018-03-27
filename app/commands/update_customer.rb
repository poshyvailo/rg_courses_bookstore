class UpdateCustomer < Rectify::Command

  def initialize(customer, params)
    @customer = customer
    @params = params
  end

  def call
    case @params[:action]
      when 'billing-address'; update_billing_address
      when 'shipping-address'; update_shipping_address
      when 'change-email'; change_email
      when 'change-password'; change_password
      else broadcast :wrong_action
    end

  end

  private

  def change_email
    current_customer.assign_attributes email_params
    if current_customer.update(email_params)
      redirect_to customer_path, notice: 'Email successfully changed'
    else
      render :show
    end
  end

  def change_password
    if current_customer.update_with_password(password_params)
      bypass_sign_in(current_customer)
      redirect_to customer_path, notice: 'Password successfully changed'
    else
      render :show
    end
  end

  def update_billing_address
    if @customer.update @params.permit(billing_address_attributes: address_attributes)
      broadcast :ok, 'Billing address successfully changed'
    else
      broadcast :fail
    end
  end

  def update_shipping_address
    if @customer.update @params.permit(shipping_address_attributes: address_attributes)
      broadcast :ok, 'Shipping address successfully changed'
    else
      broadcast :fail
    end
  end
  
  def address_attributes
    %i[firstname lastname delivery_address zipcode city phone country id]
  end
end
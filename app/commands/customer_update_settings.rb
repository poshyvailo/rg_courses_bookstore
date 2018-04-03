class CustomerUpdateSettings < Rectify::Command

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
    params = @params.permit(:email)
    if @customer.update params
      broadcast :ok, t('settings.flash.email_changed')
    else
      broadcast :fail
    end
  end

  def change_password
    params = @params.permit(:password, :password_confirmation, :current_password)
    if @customer.update_with_password params
      bypass_sign_in(@customer)
      broadcast :ok, t('settings.flash.password_changed')
    else
      broadcast :fail
    end
  end

  def update_billing_address
    params =  @params.permit(billing_address_attributes: address_attributes)
    if @customer.update params
      broadcast :ok, t('settings.flash.billing_address_changed')
    else
      broadcast :fail
    end
  end

  def update_shipping_address
    params = @params.permit(shipping_address_attributes: address_attributes)
    if @customer.update params
      broadcast :ok, t('settings.flash.shipping_address_changed')
    else
      broadcast :fail
    end
  end
  
  def address_attributes
    %i[firstname lastname delivery_address zipcode city phone country id]
  end
end
class CustomersController < ApplicationController

  before_action :authenticate_customer!

  def show; end

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
    @customer = current_customer
    logger.debug "#{params.inspect}"
    if @customer.update billing_address_params
      redirect_to customer_path, notice: 'Billing address successfully changed'
    else
      render :show
    end
  end

  def update_shipping_address
    @customer = current_customer
    logger.debug "#{params.inspect}"
    if @customer.update shipping_address_params
      redirect_to customer_path, notice: 'Shipping address successfully changed'
    else
      render :show
    end
  end

  private

  def email_params
    params.require(:customer).permit(:email)
  end

  def password_params
    params.require(:customer).permit(:password, :password_confirmation, :current_password)
  end

  def billing_address_params
    params.require(:customer).permit(
        billing_address_attributes: [:firstname, :lastname, :delivery_address, :zipcode, :city, :phone, :country, :id],
    )
  end

  def shipping_address_params
    params.require(:customer).permit(
        shipping_address_attributes: [:firstname, :lastname, :delivery_address, :zipcode, :city, :phone, :country, :id],
    )
  end
end
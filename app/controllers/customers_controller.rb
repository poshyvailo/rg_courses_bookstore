class CustomersController < ApplicationController

  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def change_email
    @customer = current_customer
    @customer.assign_attributes email_params
    if @customer.update(email_params)
      redirect_to root_path
    end
  end

  def change_password
    @customer = current_customer
    if @customer.update_with_password(password_params)
      bypass_sign_in(current_customer)
      redirect_to root_path
    else
      render "show"
    end
  end

  def update_billing_address
    @customer = current_customer
    address = @customer.billing_address
    if @customer.update billing_address_params
      redirect_to root_path
    else
      render :show
    end
  end

  def update_shipping_address
    @customer = current_customer
    address = @customer.shipping_address
    if @customer.update shipping_address_params
      redirect_to root_path
    else
      render "show"
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
        billing_address_attributes: [:firstname, :lastname, :address, :zipcode, :city, :phone, :country, :id],
    )
  end

  def shipping_address_params
    params.require(:customer).permit(
        shipping_address_attributes: [:firstname, :lastname, :address, :zipcode, :city, :phone, :country, :id],
    )
  end
end
class CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show; end

  def change_email
    current_customer.assign_attributes email_params
    if current_customer.update(email_params)
      redirect_to root_path
    end
  end

  def change_password
    if current_customer.update_with_password(password_params)
      bypass_sign_in(current_customer)
      redirect_to root_path
    else
      render "show"
    end
  end

  def update_billing_address
    if current_customer.billing_address.save(address_params)
      redirect_to root_path
    end
  end

  private

  def email_params
    params.require(:customer).permit(:email)
  end

  def password_params
    params.require(:customer).permit(:password, :password_confirmation, :current_password)
  end

  def address_params
    params.require(:customer).permit(billing_address_attributes: [
        :firstname, :lastname, :address, :zipcode, :city, :phone, :country, :id
    ])
  end
end
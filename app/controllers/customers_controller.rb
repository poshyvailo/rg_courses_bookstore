class CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show; end

  def change_email
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

  private

  def email_params
    params.require(:customer).permit(:email)
  end

  def password_params
    params.require(:customer).permit(:password, :password_confirmation, :current_password)
  end
end
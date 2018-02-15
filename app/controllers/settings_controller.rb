class SettingsController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_customer
  end

  def change_email
    @customer = Customer.find(current_customer.id)
    @customer.email = params[:customer][:email]
    @customer.save
  end
end
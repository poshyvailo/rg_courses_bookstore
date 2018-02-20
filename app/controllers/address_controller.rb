class AddressController < ApplicationController

  before_action :authenticate_customer!

  def create_billing_address
    @user = current_customer
    @user.assign_attributes address_params
    address = @user.billing_address
    if @user.valid? && @user.save
      redirect_to root_path
    else
      redirect_to customer_path
    end
  end

  private

  def address_params
    params.require(:customer).permit(billing_address_attributes: [
        :firstname, :lastname, :address, :zipcode, :city, :phone, :country, :id
    ])
  end

end
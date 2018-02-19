class AddressController < ApplicationController

  before_action :authenticate_customer!

  def create_billing_address
    current_customer.assign_attributes address_params
    if current_customer.save address_params
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
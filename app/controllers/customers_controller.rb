class CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show; end

  def update
    CustomerUpdateSettings.call(current_customer, params.require(:customer)) do
      on(:ok) do |message|
        redirect_to customers_path, notice: message
      end
      on(:fail) { render :show }
      on(:wrong_action) { redirect_to customers_path, alert: 'Wrong action' }
    end
  end
end
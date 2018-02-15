class CustomersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customer = current_customer
  end

  def settings

  end
end
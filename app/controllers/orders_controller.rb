class OrdersController < ApplicationController
  load_and_authorize_resource :order
  decorates_assigned :order

  def index
    @orders = Order.where(customer: current_customer).decorate
  end

  def show
    @order = @order.decorate
  end
end
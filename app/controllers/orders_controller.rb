class OrdersController < ApplicationController
  load_and_authorize_resource :order
  decorates_assigned :order

  def index
    @orders = Order.done_orders(current_customer)
    @orders = @orders.state_filter(params[:filter].to_sym) if params[:filter]
    @orders = @orders.decorate
  end

  def show
    @order = @order.decorate
  end
end
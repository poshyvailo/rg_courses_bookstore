class OrderItemController < ApplicationController

  before_action :initialize_order
  before_action :initialize_create_params, only: :create
  before_action :initialize_update_params, only: :update

  def create
    AddCartItem.call(@order, @params) do
      on(:ok) do |order, book|
        save_order_in_cookie order.id
        redirect_to request.referrer, notice: t('book.msg.added', title: book.title)
      end
    end
  end

  def update
    UpdateCartItem.call(@order, @params) do
      on(:ok) { redirect_to cart_path }
    end
  end

  private

  def initialize_order
    @order = current_order
  end

  def initialize_update_params
    @params = params
  end

  def initialize_create_params
    @params = params[:order_item]
  end
end
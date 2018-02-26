class OrderItemController < ApplicationController

  include OrderOperation
  include OrderItemOperation

  def create
    book_id = params[:order_item][:book_id]
    book_in_order?(book_id) ? change_item_quantity(book_id, params[:order_item][:quantity].to_i) : create_new_order_item(order_item_params)
    redirect_to  catalog_book_path(params[:order_item][:book_id]), notice: 'Book added to cart'
  end

  def update
    delete_item(params) if params.has_key? :delete
    increment_item(params) if params.has_key? :plus
    decrement_item(params) if params.has_key? :minus
    redirect_to cart_path
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id, :price)
  end

end
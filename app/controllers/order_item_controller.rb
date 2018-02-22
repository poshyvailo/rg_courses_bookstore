class OrderItemController < ApplicationController
  def create

    logger.debug "Find book by id"
    book = Book.find(params[:book_id])
    logger.debug "Get order_id"
    order_id = get_order
    logger.debug "order_id = #{order_id}"
    order_item = OrderItem.new(order_item_params)
    order_item.book = book
    order_item.price = book.price * order_item.quantity
    order_item.order = order_id
    order_item.save

    logger.debug "Save to cookie"
    cookies.encrypted[:order_id] = {
        :value => order_id.id,
        :expires => 30.days.from_now
    }
  end

  def delete

  end

  def order_item_params
    params.require(:order_item).permit(:quantity)
  end

  private

  def get_order
    Order.find_or_create_by!(id: cookies.encrypted[:order_id])
  end
end
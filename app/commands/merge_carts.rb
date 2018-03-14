class MergeCarts < Rectify::Command
  def initialize

  end

  def call
    cookie_order = order_from_cookie
    if cookie_order
      cookie_order.order_items.each do |order_item|
        if book_in_order?(order_item.book_id)
          change_item_quantity(order_item.book_id, order_item.quantity)
        else
          create_new_order_item(quantity: order_item.quantity, book_id: order_item.book_id, price: order_item.price)
        end
      end
      cookie_order.delete
    end
  end

  private

end
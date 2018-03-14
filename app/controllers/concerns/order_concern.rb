module OrderConcern
  extend ActiveSupport::Concern

  included do

    def current_order
      @current_order ||= order_from_customer || order_from_cookie || new_order
    end

    def order_from_cookie
      Order.find_by id: cookies.encrypted[:order_id]
    end

    def order_from_customer
      current_customer.orders.in_progress.first unless current_customer.nil?
    end

    def new_order
      Order.new(customer: current_customer)
    end

    def save_order_in_cookie(id)
      cookies.encrypted[:order_id] = {
          :value => id,
          :expires => 30.days.from_now
      }
    end

    def delete_order_from_cookie
      cookies.delete :order_id
    end

    def merge_orders
      cookie_order = order_from_cookie
      if cookie_order
        cookie_order.order_items.each do |order_item|
          AddCartItem.call current_order, {quantity: order_item.quantity, book_id: order_item.book_id}
        end
        cookie_order.delete
      end
    end
  end
end
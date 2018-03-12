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
      current_customer.orders.where(state: :in_progress).first unless current_customer.nil?
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

    def book_in_order?(id)
      find_book_in_order(id) ? true : false
    end

    def find_book_in_order(id)
      current_order.order_items.find_by(book_id: id)
    end

    def change_item_quantity(book_id, increment)
      find_book_in_order(book_id).increment!(:quantity, increment)
      save_order_in_cookie current_order.id
    end

    def create_new_order_item(params)
      current_order.save(validate: false) if order.new_record?
      params[:order_id] = order.id
      OrderItem.create(params)
      save_order_in_cookie order.id
    end

    def set_user_to_order
      unless order_from_customer.nil? || cookies.encrypted[:order_id].blank?
        order_from_customer.delete
      end
      unless current_order.new_record?
        order = current_order
        order.customer = current_customer
        order.save(validate: false)
      end
    end

    def merge_orders
      customer_order = order_from_customer
      cookie_order = order_from_cookie
      if customer_order && cookie_order
        cookie_order.order_items.each do |order_item|
          book_in_order?(order_item.book_id) ? change_item_quantity(book_id, quantity) : create_new_order_item(order_item_params)
        end
      end
    end
  end
end
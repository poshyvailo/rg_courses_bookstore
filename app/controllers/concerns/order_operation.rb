module OrderOperation
  extend ActiveSupport::Concern

  included do

    attr_accessor :order

    def current_order
      order_from_customer || order_from_cookie || new_order
    end

    def order_from_cookie
      Order.find_by id: cookies.encrypted[:order_id]
    end

    def order_from_customer
      if current_customer
        order = current_customer.orders.where(state: :in_progress).first
        if order && order.order_items.empty?
          order.delete
        else
          order if order
        end
      end
    end

    def new_order
      order = Order.create(customer: current_customer)
      save_order order.id
      order
    end

    def save_order(id)
      cookies.encrypted[:order_id] = {
          :value => id,
          :expires => 30.days.from_now
      }
    end

    def book_in_order?(id)
      find_book_in_order(id) ? true : false
    end

    def find_book_in_order(id)
      current_order.order_items.find_by(book_id: id)
    end

    def change_item_quantity(book_id, increment)
      find_book_in_order(book_id).increment!(:quantity, increment)
      save_order current_order.id unless current_customer
    end

    def create_new_order_item(params)
      params[:order_id] = current_order.id
      OrderItem.create(params)
      save_order current_order.id unless current_customer
    end

    def set_user_to_order
      current_order.update!(customer: current_customer)
    end
  end
end
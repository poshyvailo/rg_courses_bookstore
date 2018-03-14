module OrderItemConcern
  extend ActiveSupport::Concern

  included do
    def order_items
      @order_items = current_order.order_items
    end
  end
end
module OrderItemOperation
  extend ActiveSupport::Concern

  included do
    def delete_item(params)
      order_item = OrderItem.find(params[:id])
      order_item.delete
      flash[:notice] = "Item deleted"
      delete_order(order_item) if order_empty? (order_item)
    end

    def increment_item(params)
      increment
    end

    def decrement_item(params)
      increment(-1) if params[:order_item][:quantity].to_i > 1
    end

    private

    def increment(by = 1)
      OrderItem.find(params[:id]).increment!(:quantity, by)
    end

    def order_empty?(order_item)
      order_item.order.order_items.empty?
    end

    def delete_order(order_item)
      order_item.order.delete
      flash[:notice] = "Order deleted"
    end
  end
end
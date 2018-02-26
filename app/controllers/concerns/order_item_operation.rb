module OrderItemOperation
  extend ActiveSupport::Concern

  included do
    def delete_item(params)
      OrderItem.delete(params[:id])
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
  end
end
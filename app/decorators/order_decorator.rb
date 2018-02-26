class OrderDecorator < ApplicationDecorator
  delegate_all

  def sub_total
    object.order_items.inject(0) do |sum, item|
      sum + item.price * item.quantity
    end
  end

  def total
    sub_total
  end

  def items
    order_items.order(:id).decorate
  end
end
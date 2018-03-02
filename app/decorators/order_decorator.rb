class OrderDecorator < ApplicationDecorator
  delegate_all

  def sub_total
    object.order_items.inject(0) do |sum, item|
      sum + item.price * item.quantity
    end
  end

  def sub_total_in_euro
    "€#{sub_total}"
  end

  def total
    sub_total
  end

  def total_in_euro
    "€#{total}"
  end

  def items
    order_items
  end

  decorates_association :shipping_address
  decorates_association :billing_address
  decorates_association :order_items
end
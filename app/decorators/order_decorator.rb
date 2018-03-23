class OrderDecorator < ApplicationDecorator
  delegate_all

  decorates_association :shipping_address
  decorates_association :billing_address
  decorates_association :order_items
  decorates_association :credit_card

  def sub_total
    object.order_items.inject(0) do |sum, item|
      sum + item.price * item.quantity
    end
  end

  alias :item_total :sub_total

  def total
    sub_total + delivery_cost.to_f - coupon_discount.to_f
  end

  def delivery_cost
    object.delivery_method.price if object.delivery_method
  end

  def coupon_discount
    coupon.discount if coupon.present?
  end

  def items
    order_items
  end

  def order_number
    sprintf 'R%08d', id
  end

  def customer_email
    object.customer.email
  end

  def customer_name
    object.shipping_address.firstname
  end

  def order_date
    object.completed_date.strftime("%B %d, %Y")
  end

end
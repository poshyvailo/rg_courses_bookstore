class OrderDecorator < ApplicationDecorator
  delegate_all

  decorates_association :shipping_address
  decorates_association :billing_address
  decorates_association :order_items

  def sub_total
    object.order_items.inject(0) do |sum, item|
      sum + item.price * item.quantity
    end
  end

  alias :item_total :sub_total

  def sub_total_in_euro
    "€#{sub_total}"
  end

  def total
    sub_total + delivery_cost
  end

  def total_in_euro
    "€#{total}"
  end

  def delivery_cost
    object.delivery_method ? object.delivery_method.price : 0
  end

  def delivery_cost_in_euro
    "€#{delivery_cost}"
  end

  def items
    order_items
  end

  def in_euro(value)
    "€#{value}"
  end

  def hidden_credit_card
    "#{'**** ' * 3} #{object.credit_card.number[-4..-1]}"
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
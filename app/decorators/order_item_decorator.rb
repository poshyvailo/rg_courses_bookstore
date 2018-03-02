class OrderItemDecorator < ApplicationDecorator
  delegate_all

  def sub_total
    "€#{price * quantity}"
  end

  decorates_association :book
end
class OrderItemDecorator < ApplicationDecorator
  delegate_all

  decorates_association :book

  def sub_total
    "€#{price * quantity}"
  end

end
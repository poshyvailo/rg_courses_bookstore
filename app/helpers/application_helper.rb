module ApplicationHelper

  include OrderOperation

  def categories
    Category.all
  end

  def cart_count_items
    @order = current_order.order_items.count
  end
end

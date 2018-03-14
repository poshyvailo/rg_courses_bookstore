class UpdateCartItem < Rectify::Command
  def initialize(order, params)
    @order = order
    @params = params
  end

  def call
    delete_item if @params.has_key? :delete
    increment_item if @params.has_key? :plus
    decrement_item if @params.has_key? :minus
    broadcast :ok
  end

  private

  attr_accessor :status

  def delete_item
    OrderItem.find_by(id: @params[:id]).delete
    @order.delete if order_empty?
  end

  def increment_item
    increment
  end

  def decrement_item
    increment(-1) if @params[:order_item][:quantity].to_i > 1
  end

  def increment(by = 1)
    OrderItem.find_by(id: params[:id]).increment!(:quantity, by)
  end

  def order_empty?
    @order.order_items.empty?
  end
end
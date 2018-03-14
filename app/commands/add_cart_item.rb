class AddCartItem < Rectify::Command

  def initialize(order, params)
    @order = order
    @book = Book.find_by id: params[:book_id]
    @quantity = params[:quantity].to_i
  end

  def call
    book_in_order? ? change_item_quantity : create_new_order_item
    broadcast(:ok, @order, @book)
  end

  private

  def book_in_order?
    @order.order_items.map(&:book_id).include? @book.id
  end

  def find_book_in_order
    @order.order_items.find_by(book_id: @book)
  end

  def change_item_quantity
    find_book_in_order.increment!(:quantity, @quantity)
  end

  def create_new_order_item
    save_order if @order.new_record?
    OrderItem.create!(order_item_params)
  end

  def save_order
    @order.save(validate: false)
  end

  def order_item_params
    {
      quantity: @quantity,
      book_id: @book.id,
      price: @book.price,
      order_id: @order.id
    }
  end
end
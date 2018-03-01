class AddOrderStepToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :order_step, :string
  end
end

class AddDeliveryMethodIdToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :delivery_method_id, :integer
  end
end

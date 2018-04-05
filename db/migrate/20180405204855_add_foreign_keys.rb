class AddForeignKeys < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :orders, :addresses, column: :billing_address_id
    add_foreign_key :orders, :addresses, column: :shipping_address_id
    add_foreign_key :customers, :addresses, column: :billing_address_id
    add_foreign_key :customers, :addresses, column: :shipping_address_id
  end
end

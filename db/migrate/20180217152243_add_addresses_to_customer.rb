class AddAddressesToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :billing_address_id, :integer
    add_column :customers, :shipping_address_id, :integer
  end
end

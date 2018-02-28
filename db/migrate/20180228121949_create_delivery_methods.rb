class CreateDeliveryMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :delivery_methods do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.string :shipping_days
    end
  end
end

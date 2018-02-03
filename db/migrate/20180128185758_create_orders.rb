class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.decimal :total_price, precision: 10, scale: 2
      t.datetime :completed_date
      t.string :state
      t.references :customer, foreign_key: true
      t.references :credit_card, foreign_key: true
      t.string :billing_address
      t.string :shipping_address

      t.timestamps
    end
  end
end

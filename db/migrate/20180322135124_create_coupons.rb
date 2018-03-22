class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.decimal :discount, precision: 10, scale: 2
      t.boolean :available
      t.timestamps
    end

    add_index :coupons, :name
  end
end

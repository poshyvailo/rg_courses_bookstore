class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :descirption
      t.decimal :price, precision: 10, scale: 2
      t.string :in
      t.integer :stock
      t.references :category, foreign_key: true
      t.references :author, foreign_key: true

      t.timestamps
    end
  end
end

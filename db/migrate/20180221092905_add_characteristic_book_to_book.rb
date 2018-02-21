class AddCharacteristicBookToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :image, :string
    add_column :books, :height, :decimal, precision: 10, scale: 2
    add_column :books, :width, :decimal, precision: 10, scale: 2
    add_column :books, :depth, :decimal, precision: 10, scale: 2
    add_column :books, :year, :date
    add_column :books, :material, :string
  end
end

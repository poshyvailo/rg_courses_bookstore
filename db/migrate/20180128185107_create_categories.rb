class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :title

      t.timestamps
    end
    add_index :categories, :title, unique: true
  end
end

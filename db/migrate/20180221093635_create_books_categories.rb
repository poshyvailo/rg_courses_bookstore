class CreateBooksCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :books_categories do |t|
      t.belongs_to :book, null: false, foreign_key: true
      t.belongs_to :category, null: false, foreign_key: true

      t.index [:book_id, :category_id], unique: true
      t.index [:category_id, :book_id], unique: true
    end
  end
end

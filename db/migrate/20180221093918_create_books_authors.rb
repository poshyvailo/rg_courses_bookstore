class CreateBooksAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :books_authors do |t|
      t.belongs_to :book, null: false, foreign_key: true
      t.belongs_to :author, null: false, foreign_key: true

      t.index [:book_id, :author_id], unique: true
      t.index [:author_id, :book_id], unique: true
    end
  end
end

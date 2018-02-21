class RemoveCategoryAndAuthorFromBook < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :category_id, :integer
    remove_column :books, :author_id, :integer
  end
end

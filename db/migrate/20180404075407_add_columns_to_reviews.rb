class AddColumnsToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :firstname, :string
    add_column :reviews, :lastname, :string
    add_column :reviews, :verified, :bool, default: false
  end
end

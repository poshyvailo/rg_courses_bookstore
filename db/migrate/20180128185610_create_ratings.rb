class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.text :text_review
      t.integer :rating_number, limit: 2
      t.references :book, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end

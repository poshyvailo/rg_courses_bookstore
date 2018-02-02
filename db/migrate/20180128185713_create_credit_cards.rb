class CreateCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :credit_cards do |t|
      t.string :firstname
      t.string :lastname
      t.string :number
      t.string :cvv, limit: 3
      t.integer :expiration_month, limit: 2
      t.integer :expiration_year, limit: 2
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end

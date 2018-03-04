class ChangeCreditCardTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :credit_cards, :lastname
    remove_column :credit_cards, :expiration_month
    remove_column :credit_cards, :expiration_year
    remove_column :credit_cards, :customer_id

    rename_column :credit_cards, :firstname, :card_owner

    add_column :credit_cards, :expiration, :date
  end
end

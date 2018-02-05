class RemoveFieldsFromCustomer < ActiveRecord::Migration[5.1]
  def change
    remove_column :customers, :firstname, :string
    remove_column :customers, :lastname, :string
    remove_column :customers, :email, :string
    remove_column :customers, :password_digest, :string
  end
end

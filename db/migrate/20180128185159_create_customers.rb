class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :password_digest

      t.timestamps
    end
    add_index :customers, :email, unique: true
  end
end

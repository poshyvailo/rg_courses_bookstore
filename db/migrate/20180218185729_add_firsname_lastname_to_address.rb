class AddFirsnameLastnameToAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :firstname, :string
    add_column :addresses, :lastname, :string
  end
end

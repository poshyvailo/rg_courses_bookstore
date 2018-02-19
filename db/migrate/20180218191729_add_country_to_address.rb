class AddCountryToAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :country, :string
  end
end

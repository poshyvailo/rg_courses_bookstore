class DropCountries < ActiveRecord::Migration[5.1]
  def change
    drop_table :countries
  end
end

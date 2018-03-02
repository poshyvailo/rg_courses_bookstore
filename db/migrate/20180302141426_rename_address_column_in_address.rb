class RenameAddressColumnInAddress < ActiveRecord::Migration[5.1]
  def change
    rename_column :addresses, :address, :delivery_address
  end
end

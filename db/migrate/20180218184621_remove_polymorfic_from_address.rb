class RemovePolymorficFromAddress < ActiveRecord::Migration[5.1]
  def change
    remove_column :addresses, :addressable_type, :string
    remove_column :addresses, :addressable_id, :integer
  end
end

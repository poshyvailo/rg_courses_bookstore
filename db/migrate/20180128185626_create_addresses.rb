class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.text :address
      t.string :zipcode
      t.string :city
      t.string :phone
      t.references :country, foreign_key: true

      t.timestamps
    end
  end
end

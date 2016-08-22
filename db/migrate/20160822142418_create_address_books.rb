class CreateAddressBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :address_books do |t|
      t.integer :customer_id
      t.integer :company_id
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.integer :zipcode

      t.timestamps
    end
  end
end

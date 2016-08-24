class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.integer :ip_address_id
      t.integer :address_book_id
      t.integer :account_number
      t.string :first_name
      t.string :last_name
      t.string :home_phone
      t.string :cell_phone
      t.string :work_phone
      t.text :notes
      t.boolean :active, default: false
      t.string :email

      t.timestamps
    end
  end
end

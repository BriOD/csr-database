class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.integer :ip_range_id
      t.string :first_name
      t.string :last_name
      t.integer :address_book_id
      t.integer :home_phone
      t.integer :cell_phone
      t.integer :work_phone
      t.text :notes
      t.boolean :active, default: false
      t.string :email
      t.integer :lease_id
      t.integer :company_id
      t.integer :webspace_id

      t.timestamps
    end
  end
end

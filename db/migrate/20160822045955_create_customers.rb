class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.integer :ip_range_id
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.integer :zipcode
      t.integer :home_phone
      t.integer :cell_phone
      t.integer :work_phone
      t.text :notes
      t.boolean :tdnp, default: false
      t.string :email
      t.integer :lease_id
      t.integer :company_id
      t.integer :webspace_id

      t.timestamps
    end
  end
end

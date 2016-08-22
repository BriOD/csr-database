class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.integer :customer_id
      t.string :name
      t.string :contact_first_name
      t.string :contact_last_name
      t.string :contact_email
      t.string :billing_email
      t.integer :address_book_id
      t.string :main_number
      t.string :contact_number
      t.string :fax

      t.timestamps
    end
  end
end

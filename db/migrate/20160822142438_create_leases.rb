class CreateLeases < ActiveRecord::Migration[5.0]
  def change
    create_table :leases do |t|
      t.integer :customer_id
      t.string :modem_manufacturer
      t.string :modem_model
      t.string :modem_serial
      t.string :modem_mac
      t.string :router_manufacturer
      t.string :router_model
      t.string :router_serial
      t.string :router_mac
      t.boolean :tr069, default: false

      t.timestamps
    end
  end
end

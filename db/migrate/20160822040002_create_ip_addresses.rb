class CreateIpAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :ip_addresses do |t|
      t.integer :ip_range_id, null: false
      t.integer :customer_id
      t.string :ip, null: false, default: ''
      t.boolean :reserved, default: false

      t.timestamps
    end
  end
end

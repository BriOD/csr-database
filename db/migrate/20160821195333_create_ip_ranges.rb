class CreateIpRanges < ActiveRecord::Migration[5.0]
  def change
    create_table :ip_ranges do |t|
      t.string :network, null: false, default: ''
      t.string :gateway, null: false, default: ''
      t.integer :service_id, null: false, default: 1

      t.timestamps
    end
  end
end

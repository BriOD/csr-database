class CreateWebspaces < ActiveRecord::Migration[5.0]
  def change
    create_table :webspaces do |t|
      t.integer :customer_id
      t.boolean :active, default: false
      t.string :url
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end

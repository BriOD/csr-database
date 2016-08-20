class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.string :icon,      null: false, default: ''
      t.string :main_type, null: false, default: ''
      t.string :name,      null: false, default: ''
      t.string :sub_type
      t.string :sub_name

      t.timestamps
    end
  end
end

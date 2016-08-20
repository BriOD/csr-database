class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.string :service_icon,      null: false, default: ''
      t.string :service_type,      null: false, default: ''
      t.string :service_name,      null: false, default: ''
      t.string :sub_service_type,  null: false, default: '', unique: true
      t.string :sub_service_name,  null: false, default: '', unique: true

      t.timestamps
    end
  end
end

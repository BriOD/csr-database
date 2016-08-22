class CreateWebspaces < ActiveRecord::Migration[5.0]
  def change
    create_table :webspaces do |t|

      t.timestamps
    end
  end
end

class CreateAdminConfigs < ActiveRecord::Migration
  def change
    create_table :admin_configs do |t|
      t.string :name
      t.string :value

      t.timestamps
    end

    add_index :admin_configs, :name, unique: true
  end
end

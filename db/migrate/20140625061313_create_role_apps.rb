class CreateRoleApps < ActiveRecord::Migration
  def change
    create_table :role_apps do |t|
      t.string :head
      t.text :paths
      t.integer :user_id

      t.timestamps
    end
  end
end

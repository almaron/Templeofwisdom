class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :head
      t.text :paths

      t.timestamps
    end
  end
end

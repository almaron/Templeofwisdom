class CreateCharRoles < ActiveRecord::Migration
  def change
    create_table :char_roles do |t|
      t.integer :role_id
      t.integer :char_id
      t.integer :points,   default:0

      t.timestamps
    end
  end
end

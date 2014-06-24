class CreateCharRoleSkills < ActiveRecord::Migration
  def change
    create_table :char_role_skills do |t|
      t.integer :char_role_id
      t.integer :skill_id
      t.integer :done,     default: 0

      t.timestamps
    end
  end
end

class CreateCharSkills < ActiveRecord::Migration
  def change
    create_table :char_skills do |t|
      t.integer :char_id,     null: false
      t.integer :skill_id,    null: false
      t.integer :level_id,    null: false

      t.timestamps
    end

    add_index :char_skills, :char_id
  end
end

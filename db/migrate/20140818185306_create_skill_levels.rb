class CreateSkillLevels < ActiveRecord::Migration
  def change
    create_table :skill_levels do |t|
      t.integer :skill_id
      t.integer :level_id
      t.text :description
      t.text :techniques
      t.text :advice

      t.timestamps
    end

    add_index :skill_levels, :skill_id
  end
end

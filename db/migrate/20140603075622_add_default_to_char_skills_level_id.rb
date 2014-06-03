class AddDefaultToCharSkillsLevelId < ActiveRecord::Migration
  def change
    change_column :char_skills, :level_id, :integer, default: 1
  end
end

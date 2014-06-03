class RenameTypeInSkills < ActiveRecord::Migration
  def change
    rename_column :skills, :type, :skill_type
  end
end

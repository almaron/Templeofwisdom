class AddAdviceToSkills < ActiveRecord::Migration
  def up
    add_column :skills, :advice, :text
  end

  def down
    remove_column :skills, :advice
  end
end

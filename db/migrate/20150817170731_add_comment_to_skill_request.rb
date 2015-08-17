class AddCommentToSkillRequest < ActiveRecord::Migration
  def change
    add_column :skill_requests, :comment, :string
  end
end

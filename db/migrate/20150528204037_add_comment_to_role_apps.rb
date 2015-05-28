class AddCommentToRoleApps < ActiveRecord::Migration
  def change
    add_column :role_apps, :comment, :text, default: nil
  end
end

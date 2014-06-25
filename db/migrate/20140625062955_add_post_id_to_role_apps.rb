class AddPostIdToRoleApps < ActiveRecord::Migration
  def change
    add_column :role_apps, :post_id, :integer
  end
end

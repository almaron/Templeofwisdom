class AddCommentToAdminConfigs < ActiveRecord::Migration
  def change
    add_column :admin_configs, :comment, :string
  end
end

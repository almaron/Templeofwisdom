class RemovePathsFromRoles < ActiveRecord::Migration
  def change
    remove_column :roles, :paths
  end
end

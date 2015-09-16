class AddHiddenToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :hidden, :boolean, default: false
  end
end

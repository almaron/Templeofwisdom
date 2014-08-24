class AddPointsAndRolesToLevels < ActiveRecord::Migration
  def change
    add_column :levels, :phisic_roles, :integer
    add_column :levels, :magic_roles, :integer
    add_column :levels, :phisic_points, :integer
    add_column :levels, :phisic_points_discount, :integer
    add_column :levels, :magic_points, :integer
    add_column :levels, :magic_points_discount, :integer
  end
end

class SetDefaultDiscountOnSkills < ActiveRecord::Migration
  def up
    change_column :skills, :discount, :string, default: ""
  end

  def down
    change_column :skills, :discount, :string, default: nil
  end
end

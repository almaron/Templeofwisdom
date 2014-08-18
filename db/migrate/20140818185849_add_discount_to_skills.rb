class AddDiscountToSkills < ActiveRecord::Migration
  def up
    add_column :skills, :discount, :string
  end

  def down
    remove_column :skills, :discount
  end
end

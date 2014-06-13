class AddCategoryToForums < ActiveRecord::Migration
  def change
    add_column :forums, :is_category, :integer, default: 0
  end
end

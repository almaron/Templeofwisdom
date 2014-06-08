class AddSortOrderToForums < ActiveRecord::Migration
  def change
    add_column :forums, :sort_order, :integer, default: 0
  end
end

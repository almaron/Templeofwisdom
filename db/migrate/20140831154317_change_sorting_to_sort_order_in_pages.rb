class ChangeSortingToSortOrderInPages < ActiveRecord::Migration
  def up
    rename_column :pages, :sorting, :sort_order
  end

  def down
    rename_column :pages, :sort_order, :sorting
  end
end

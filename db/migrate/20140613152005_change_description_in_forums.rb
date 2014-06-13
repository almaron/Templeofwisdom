class ChangeDescriptionInForums < ActiveRecord::Migration
  def change
    change_column :forums, :description, :text
  end
end

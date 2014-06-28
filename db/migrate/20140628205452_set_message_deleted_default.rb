class SetMessageDeletedDefault < ActiveRecord::Migration
  def change
    change_column :messages, :deleted, :integer, default: 0
  end
end

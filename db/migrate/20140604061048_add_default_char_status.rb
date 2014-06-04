class AddDefaultCharStatus < ActiveRecord::Migration
  def change
    change_column :chars, :status_id, :integer, default: 2
  end
end

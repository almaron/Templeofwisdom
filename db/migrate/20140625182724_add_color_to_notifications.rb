class AddColorToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :priority, :integer, default: 3
  end
end

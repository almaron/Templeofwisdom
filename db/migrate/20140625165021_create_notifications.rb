class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :head
      t.text :text
      t.integer :read,     default:0

      t.timestamps
    end
  end
end

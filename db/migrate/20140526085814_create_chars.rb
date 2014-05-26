class CreateChars < ActiveRecord::Migration
  def change
    create_table :chars do |t|
      t.string :name
      t.integer :group_id
      t.string :status_line
      t.string :avatar
      t.integer :status_id
      t.integer :open_player
      t.integer :profile_topic_id

      t.timestamps
    end
  end
end

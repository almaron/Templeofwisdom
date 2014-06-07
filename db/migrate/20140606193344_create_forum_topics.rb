class CreateForumTopics < ActiveRecord::Migration
  def change
    create_table :forum_topics do |t|
      t.integer :forum_id
      t.string :poster_name
      t.integer :closed
      t.integer :hidden
      t.integer :last_post_id
      t.datetime :last_post_at
      t.string :last_post_char_name

      t.timestamps
    end
  end
end

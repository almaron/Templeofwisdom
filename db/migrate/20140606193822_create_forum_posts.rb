class CreateForumPosts < ActiveRecord::Migration
  def change
    create_table :forum_posts do |t|
      t.integer :topic_id
      t.text :text
      t.integer :char_id
      t.integer :user_id
      t.string :ip
      t.text :comment
      t.string :commenter
      t.datetime :commented_at

      t.timestamps
    end
  end
end

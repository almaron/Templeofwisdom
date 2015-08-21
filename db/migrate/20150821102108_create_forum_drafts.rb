class CreateForumDrafts < ActiveRecord::Migration
  def change
    create_table :forum_drafts do |t|
      t.integer :user_id
      t.integer :topic_id
      t.integer :char_id
      t.integer :avatar_id
      t.text :text

      t.timestamps
    end

    add_index :forum_drafts, :user_id
    add_index :forum_drafts, [:user_id, :topic_id], unique: true
  end
end

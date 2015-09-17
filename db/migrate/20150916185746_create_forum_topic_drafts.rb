class CreateForumTopicDrafts < ActiveRecord::Migration
  def change
    create_table :forum_topic_drafts do |t|
      t.integer :user_id, null: false
      t.integer :forum_id, null: false
      t.integer :char_id, null: false
      t.integer :avatar_id
      t.string :head, default: ''
      t.text :text, null: false

      t.timestamps
    end

    add_index :forum_topic_drafts, :user_id
    add_index :forum_topic_drafts, [:forum_id, :user_id], unique: true
  end
end

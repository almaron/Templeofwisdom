class CreateForumTopicReads < ActiveRecord::Migration
  def change
    create_table :forum_topic_reads do |t|
      t.integer :user_id
      t.integer :forum_topic_id

      t.timestamps
    end

    add_index :forum_topic_reads, :user_id
    add_index :forum_topic_reads, :forum_topic_id
  end
end

class AddHeadToForumTopics < ActiveRecord::Migration
  def change
    add_column :forum_topics, :head, :string, null: false
  end
end

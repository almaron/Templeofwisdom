class AddCharIdToForumTopicsAndPosts < ActiveRecord::Migration
  def change
    add_column :forum_topics, :char_id, :integer

    change_column :forum_topics, :hidden, :integer, default: 0
    change_column :forum_topics, :closed, :integer, default: 0
  end
end

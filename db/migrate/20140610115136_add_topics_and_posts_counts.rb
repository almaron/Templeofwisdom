class AddTopicsAndPostsCounts < ActiveRecord::Migration
  def change
    add_column :forums, :topics_count, :integer, default: 0
    add_column :forums, :posts_count, :integer, default: 0
    add_column :forum_topics, :posts_count, :integer, default: 0
  end
end

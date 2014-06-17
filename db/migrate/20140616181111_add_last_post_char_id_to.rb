class AddLastPostCharIdTo < ActiveRecord::Migration
  def change
    add_column :forum_topics, :last_post_char_id, :integer
  end
end

class AddAvatarIdToForumPost < ActiveRecord::Migration
  def change
    add_column :forum_posts, :avatar_id, :integer
  end
end

class AddUserIpToGuestPosts < ActiveRecord::Migration
  def change
    add_column :guest_posts, :user, :string, null: false
    add_column :guest_posts, :ip, :string, null: false
  end
end

class CreateGuestPosts < ActiveRecord::Migration
  def change
    create_table :guest_posts do |t|
      t.string :head
      t.text :content
      t.text :answer

      t.timestamps
    end
  end
end

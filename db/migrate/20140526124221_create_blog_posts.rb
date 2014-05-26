class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :head
      t.text :text
      t.string :author

      t.timestamps
    end
  end
end

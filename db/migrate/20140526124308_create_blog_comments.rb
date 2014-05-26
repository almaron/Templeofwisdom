class CreateBlogComments < ActiveRecord::Migration
  def change
    create_table :blog_comments do |t|
      t.integer :blog_post_id,   null: false
      t.text :comment
      t.integer :user_id
      t.string :author

      t.timestamps
    end
  end
end

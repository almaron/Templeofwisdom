class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :name,          null: false
      t.string :ancestry
      t.string :image
      t.string :description
      t.integer :technical,    default:0
      t.integer :hidden,       default:0
      t.integer :last_post_id
      t.integer :last_post_topic_id
      t.datetime :last_post_at
      t.string :last_post_char_name

      t.timestamps
    end
  end
end

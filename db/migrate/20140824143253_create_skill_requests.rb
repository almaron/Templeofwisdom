class CreateSkillRequests < ActiveRecord::Migration
  def change
    create_table :skill_requests do |t|
      t.integer :user_id
      t.integer :char_id
      t.integer :skill_id
      t.integer :level_id
      t.integer :forum_post_id
      t.integer :points
      t.integer :roles

      t.timestamps
    end

    add_index :skill_requests, :char_id
  end
end

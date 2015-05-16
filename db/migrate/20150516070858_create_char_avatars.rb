class CreateCharAvatars < ActiveRecord::Migration
  def change
    create_table :char_avatars do |t|
      t.integer :char_id, null: false
      t.string :image
      t.boolean :default, null: false, default: true

      t.timestamps
    end
    add_index :char_avatars, :char_id
  end
end

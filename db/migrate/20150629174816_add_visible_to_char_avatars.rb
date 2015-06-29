class AddVisibleToCharAvatars < ActiveRecord::Migration
  def change
    add_column :char_avatars, :visible, :boolean, default: true
    add_index :char_avatars, [:char_id, :visible]
  end
end

class ChangeCharAvatars < ActiveRecord::Migration
  def change
    change_column :char_avatars, :char_id, :integer, null: true
  end
end

class RemoveAvatarFromChars < ActiveRecord::Migration
  def up
    remove_column :chars, :avatar
  end

  def down
    add_column :chars, :avatar, :string
  end
end

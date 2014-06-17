class AddLastPostCharIdToForums < ActiveRecord::Migration
  def change
    add_column :forums, :last_post_char_id, :integer
  end
end

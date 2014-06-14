class AddDefaultToForumTopicsHidden < ActiveRecord::Migration
  def change
    change_column :forum_topics, :hidden, :integer, default:0
  end
end

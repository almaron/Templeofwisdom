class AddTopicIdsToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :topic_ids, :string
  end
end

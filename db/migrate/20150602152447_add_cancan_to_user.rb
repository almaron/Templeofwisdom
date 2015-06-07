class AddCancanToUser < ActiveRecord::Migration
  def change
    add_column :users, :cancan, :integer, default: 0
  end
end

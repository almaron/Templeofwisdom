class AddReceiveListToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :receive_list, :string
  end
end

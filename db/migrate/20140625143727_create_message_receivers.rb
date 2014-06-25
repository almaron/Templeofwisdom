class CreateMessageReceivers < ActiveRecord::Migration
  def change
    create_table :message_receivers do |t|
      t.integer :message_id
      t.integer :user_id
      t.integer :char_id
      t.integer :read,    default: 0

      t.timestamps
    end
  end
end

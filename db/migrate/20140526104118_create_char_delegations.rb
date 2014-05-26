class CreateCharDelegations < ActiveRecord::Migration
  def change
    create_table :char_delegations do |t|
      t.integer :char_id,   null: false
      t.integer :user_id,   null: false
      t.date :ending
      t.integer :owner,     default: 0
      t.integer :default,   default: 0

      t.timestamps
    end

    add_index :char_delegations, :user_id
  end
end

class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :char_id
      t.string :head
      t.text :text
      t.integer :deleted

      t.timestamps
    end
  end
end

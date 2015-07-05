class CreateMasterQuestions < ActiveRecord::Migration
  def change
    create_table :master_questions do |t|
      t.integer :user_id, null: false
      t.integer :status_id, default: 1
      t.string :head, null: false
      t.text :text

      t.timestamps
    end

    add_index :master_questions, :status_id
    add_index :master_questions, :user_id
  end
end

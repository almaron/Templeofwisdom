class CreateMasterAnswers < ActiveRecord::Migration
  def change
    create_table :master_answers do |t|
      t.integer :question_id
      t.integer :user_id
      t.text :text
      t.string :answer_status

      t.timestamps
    end

    add_index :master_answers, :question_id
  end
end

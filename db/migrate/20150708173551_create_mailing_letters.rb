class CreateMailingLetters < ActiveRecord::Migration
  def change
    create_table :mailing_letters do |t|
      t.string :subject
      t.text :text
      t.integer :user_id
      t.boolean :done, default: false

      t.timestamps
    end
  end
end

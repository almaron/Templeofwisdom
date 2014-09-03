class CreateJournalImages < ActiveRecord::Migration
  def change
    create_table :journal_images do |t|
      t.integer :page_id
      t.string :image

      t.timestamps
    end

    add_index :journal_images, :page_id
  end
end

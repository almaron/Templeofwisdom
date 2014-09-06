class CreateJournalBlocks < ActiveRecord::Migration
  def change
    create_table :journal_blocks do |t|
      t.integer :page_id
      t.text :content
      t.string :image

      t.timestamps
    end

    add_index :journal_blocks, :page_id
  end
end

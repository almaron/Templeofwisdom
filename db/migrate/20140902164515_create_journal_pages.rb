class CreateJournalPages < ActiveRecord::Migration
  def change
    create_table :journal_pages do |t|
      t.integer :journal_id
      t.string :head
      t.string :page_type
      t.integer :sort_index
      t.text :content_text
      t.string :content_line

      t.timestamps
    end

    add_index :journal_pages, [:journal_id, :sort_index]
  end
end

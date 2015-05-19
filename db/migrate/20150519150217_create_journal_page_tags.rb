class CreateJournalPageTags < ActiveRecord::Migration
  def change
    create_table :journal_page_tags do |t|
      t.integer :page_id
      t.integer :tag_id

      t.timestamps
    end

    add_index :journal_page_tags, :page_id
    add_index :journal_page_tags, :tag_id
  end
end

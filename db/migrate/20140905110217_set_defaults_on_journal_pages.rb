class SetDefaultsOnJournalPages < ActiveRecord::Migration
  def up
    change_column :journal_pages, :sort_index, :integer, default: 0
    change_column :journal_pages, :page_type, :string, default: 'article'
    change_column :journal_pages, :content_line, :string, default: ''
  end

  def down
    change_column :journal_pages, :sort_index, :integer, default: nil
    change_column :journal_pages, :page_type, :string, default: nil
    change_column :journal_pages, :content_line, :string, default: nil
  end
end

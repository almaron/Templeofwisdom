class CreateJournalTags < ActiveRecord::Migration
  def change
    create_table :journal_tags do |t|
      t.string :name
    end
  end
end

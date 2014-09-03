class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.string :head
      t.string :cover
      t.datetime :publish_date

      t.timestamps
    end

    add_index :journals, :publish_date
  end
end

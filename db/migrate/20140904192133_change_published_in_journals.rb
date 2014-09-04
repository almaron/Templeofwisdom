class ChangePublishedInJournals < ActiveRecord::Migration
  def up
    remove_column :journals, :publish_date
    add_column :journals, :published, :boolean, default: false
    add_column :journals, :description, :string
  end

  def down
    remove_column :journals, :published
    remove_column :journals, :description
    add_column :journals, :publish_date, :datetime
  end
end

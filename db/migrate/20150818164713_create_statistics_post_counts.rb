class CreateStatisticsPostCounts < ActiveRecord::Migration
  def change
    create_table :statistics_post_counts do |t|
      t.date :date
      t.integer :count
    end

    add_index :statistics_post_counts, :date
  end
end

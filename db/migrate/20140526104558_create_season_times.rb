class CreateSeasonTimes < ActiveRecord::Migration
  def change
    create_table :season_times do |t|
      t.integer :season_id
      t.integer :begins

      t.timestamps
    end

    add_index :season_times, :begins
  end
end

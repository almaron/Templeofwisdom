class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :name, null: false
    end
  end
end

class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name,      null: false
      t.text :description
      t.string :type,      default: "phisic"

      t.timestamps
    end

    add_index :skills, :type
  end
end

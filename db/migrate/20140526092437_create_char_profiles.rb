class CreateCharProfiles < ActiveRecord::Migration
  def change
    create_table :char_profiles do |t|
      t.integer :char_id,            null: false
      t.string :birth_date
      t.integer :age
      t.integer :season_id
      t.string :place
      t.string :beast
      t.text :phisics
      t.text :bio
      t.text :look
      t.text :character
      t.text :items
      t.string :person
      t.text :comment
      t.integer :points,             default:  0

      t.timestamps
    end
  end
end

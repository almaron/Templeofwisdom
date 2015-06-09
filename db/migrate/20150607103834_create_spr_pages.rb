class CreateSprPages < ActiveRecord::Migration
  def change
    create_table :spr_pages do |t|
      t.string :spr
      t.string :name
      t.string :image
      t.text :attrs

      t.timestamps
    end

    add_index :spr_pages, :spr
  end
end

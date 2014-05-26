class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :author
      t.string :head
      t.text :text

      t.timestamps
    end
  end
end

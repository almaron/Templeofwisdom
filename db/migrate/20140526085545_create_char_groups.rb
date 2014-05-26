class CreateCharGroups < ActiveRecord::Migration
  def change
    create_table :char_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end

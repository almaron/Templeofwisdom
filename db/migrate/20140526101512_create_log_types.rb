class CreateLogTypes < ActiveRecord::Migration
  def change
    create_table :log_types do |t|
      t.string :name
      t.string :ancestry

      t.timestamps
    end
  end
end

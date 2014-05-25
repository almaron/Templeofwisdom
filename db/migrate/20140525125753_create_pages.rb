class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :head
      t.string :page_title
      t.string :page_alias
      t.string :ancestry
      t.text :content
      t.string :partial
      t.string :partial_params
      t.integer :published,        default: 0
      t.integer :hide_menu,        default: 0
      t.integer :sorting,          default: 0
      t.string :meta_title
      t.string :meta_description
      t.string :meta_keywords

      t.timestamps
    end

    add_index :pages, :page_alias, unique: true
    add_index :pages, :ancestry
  end
end

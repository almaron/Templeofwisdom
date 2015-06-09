class AddSlugToSprPages < ActiveRecord::Migration
  def change
    add_column :spr_pages, :slug, :string
    add_index :spr_pages, :slug
  end
end

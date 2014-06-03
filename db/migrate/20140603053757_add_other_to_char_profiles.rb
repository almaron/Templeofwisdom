class AddOtherToCharProfiles < ActiveRecord::Migration
  def change
    add_column :char_profiles, :other, :text
  end
end

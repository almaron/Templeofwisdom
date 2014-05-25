class CreateAuthentications < ActiveRecord::Migration
  def change
  add_index :authentications, [:provider, :uid], unique: true
  end
end

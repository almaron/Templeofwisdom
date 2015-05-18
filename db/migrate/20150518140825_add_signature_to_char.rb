class AddSignatureToChar < ActiveRecord::Migration
  def change
    add_column :chars, :signature, :string, default: ''
  end
end

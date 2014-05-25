class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name,             :null => false
      t.string :email,            :null => false
      t.string :group,            :default => 'user'
      t.string :crypted_password, :null => false
      t.string :salt,             :null => false

      t.timestamps
    end

    add_index :users, :name, unique: true
  end
end
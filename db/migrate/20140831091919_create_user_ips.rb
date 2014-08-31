class CreateUserIps < ActiveRecord::Migration
  def change
    create_table :user_ips do |t|
      t.integer :user_id
      t.string :ip
    end

    add_index :user_ips, :user_id
    add_index :user_ips, :ip
  end
end

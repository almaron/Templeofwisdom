class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.integer :user_id,       null: false
      t.string :full_name
      t.date :birth_date
      t.string :icq
      t.string :skype
      t.string :contacts
      t.integer :viewcontacts,  default: 0

      t.timestamps
    end
  end
end

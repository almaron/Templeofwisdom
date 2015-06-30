class CreateSysLogs < ActiveRecord::Migration
  def change
    create_table :sys_logs do |t|
      t.string :user
      t.string :message
      t.integer :log_type_id

      t.timestamps
    end
    add_index :sys_logs, :log_type_id
  end
end

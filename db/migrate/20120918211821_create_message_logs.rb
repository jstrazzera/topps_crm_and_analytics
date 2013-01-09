class CreateMessageLogs < ActiveRecord::Migration
  def change
    create_table :message_logs do |t|
      t.string :method
      t.string :kind
      t.integer :fan_id
      t.boolean :success

      t.timestamps
    end
  end
end

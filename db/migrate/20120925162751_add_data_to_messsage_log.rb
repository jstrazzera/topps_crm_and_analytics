class AddDataToMesssageLog < ActiveRecord::Migration
  def change
    add_column :message_logs, :data, :text
  end
end

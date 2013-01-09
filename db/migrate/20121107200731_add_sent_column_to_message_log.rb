class AddSentColumnToMessageLog < ActiveRecord::Migration
  def change
    add_column :message_logs, :sent, :boolean
  end
end

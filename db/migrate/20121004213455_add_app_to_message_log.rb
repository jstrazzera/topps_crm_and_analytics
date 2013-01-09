class AddAppToMessageLog < ActiveRecord::Migration
  def change
    add_column :message_logs, :app, :string
  end
end

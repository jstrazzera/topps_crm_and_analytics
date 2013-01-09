class AddVersionToMessageLog < ActiveRecord::Migration
  def change
    add_column :message_logs, :version, :string
  end
end

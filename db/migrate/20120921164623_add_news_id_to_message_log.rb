class AddNewsIdToMessageLog < ActiveRecord::Migration
  def up
  	change_table :message_logs do |t|
  		t.integer :blurb_id
  	end
  end

  def down
  	remove_column :message_logs, :blurb_id
  end
end

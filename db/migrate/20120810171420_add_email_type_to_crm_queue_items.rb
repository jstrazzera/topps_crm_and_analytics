class AddEmailTypeToCrmQueueItems < ActiveRecord::Migration
  def up
  	change_table :crm_queue_items do |t|
  		t.string :email_type
  	end
  end

  def down
  	remove_column :crm_queue_items, :email_type
  end
end

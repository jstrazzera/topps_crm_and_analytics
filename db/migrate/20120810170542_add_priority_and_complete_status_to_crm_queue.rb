class AddPriorityAndCompleteStatusToCrmQueue < ActiveRecord::Migration
  def up
  	change_table :crm_queue_items do |t|
  		t.boolean :completed
  	end
  end

  def down
  	remove_column :crm_queue_items, :completed
  end
end

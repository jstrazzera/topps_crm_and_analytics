class ChangeEmailinCrmQueueToString < ActiveRecord::Migration
  def up
  	change_column :crm_queue_items, :destinaiton_email_address, :string
  end

  def down
    change_column :crm_queue_items, :destinaiton_email_address, :integer

  end
end

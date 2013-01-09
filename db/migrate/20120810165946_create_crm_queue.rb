class CreateCrmQueue < ActiveRecord::Migration
  def change
    create_table :crm_queue_items do |t|
      t.string :app
      t.integer :destinaiton_email_address
      t.string :data
      t.timestamps
    end
  end
end

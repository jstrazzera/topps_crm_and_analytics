class CreateMailingListEmails < ActiveRecord::Migration
  def change
    create_table :mailing_list_emails do |t|
      t.string :address
      t.integer :team_id
      t.timestamps
    end
  end
end

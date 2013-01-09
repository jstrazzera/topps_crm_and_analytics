class CreateBlackListedEmails < ActiveRecord::Migration
  def change
    create_table :black_listed_emails do |t|
      t.string :type
      t.string :address
      t.string :reason

      t.timestamps
    end
  end
end

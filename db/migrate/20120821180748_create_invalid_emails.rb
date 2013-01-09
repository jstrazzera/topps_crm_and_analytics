class CreateInvalidEmails < ActiveRecord::Migration
  def change
    create_table :invalid_emails do |t|
      t.string :address
      t.string :reason
      t.datetime :date

      t.timestamps
    end
  end
end

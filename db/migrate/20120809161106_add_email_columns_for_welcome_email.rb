class AddEmailColumnsForWelcomeEmail < ActiveRecord::Migration
  def up
  	change_table :teams do |t|
  		t.text :welcome_email_subject
  		t.text :welcome_email_body
  	end
  end

  def down
  	remove_column :teams, :welcome_email_subject
  	remove_column :teams, :welcome_email_body

  end
end

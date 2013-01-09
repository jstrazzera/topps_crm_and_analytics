class ChangeReasoninBlacklisttoText < ActiveRecord::Migration
  def up
  	change_column :black_listed_emails, :reason, :text
  end

  def down
  	change_column :black_listed_emails, :reason, :string
  end
end

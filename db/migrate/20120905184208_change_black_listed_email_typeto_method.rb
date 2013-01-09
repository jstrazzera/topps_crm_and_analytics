class ChangeBlackListedEmailTypetoMethod < ActiveRecord::Migration
  def up
  	rename_column :black_listed_emails, :type, :method
  end

  def down
  	rename_column :black_listed_emails, :method, :type
  end
end

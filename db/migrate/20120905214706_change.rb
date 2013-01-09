class Change < ActiveRecord::Migration
  def up
  	rename_table :email_templates, :templates
  end

  def down
  	rename_talbe :templates, :email_templates
  end
end

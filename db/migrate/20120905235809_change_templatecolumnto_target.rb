class ChangeTemplatecolumntoTarget < ActiveRecord::Migration
  def up
  	rename_column :templates, :email_type, :target
  end

  def down
  	rename_column :templates, :target, :email_type
  end
end

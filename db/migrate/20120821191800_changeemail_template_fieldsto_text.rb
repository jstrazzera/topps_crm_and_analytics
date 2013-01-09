class ChangeemailTemplateFieldstoText < ActiveRecord::Migration
  def up
  	change_column :email_templates, :body, :text
  	change_column :email_templates, :subject, :text

  end

  def down
  	change_column :email_templates, :body, :string
  	change_column :email_templates, :subject, :string

  end
end

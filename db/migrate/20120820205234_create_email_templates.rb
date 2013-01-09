class CreateEmailTemplates < ActiveRecord::Migration
  def change
    create_table :email_templates do |t|
      t.string :email_type
      t.string :subject
      t.string :body

      t.timestamps
    end
  end
end

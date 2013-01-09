class AddAppToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :app, :string
  end
end

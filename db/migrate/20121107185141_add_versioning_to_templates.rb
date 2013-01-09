class AddVersioningToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :archived, :boolean
    add_column :templates, :version, :string
  end
end

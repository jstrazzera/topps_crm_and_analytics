class AddDeepLinkKeyAndValueToTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :deep_link_key, :string
    add_column :templates, :deep_link_value, :string
  end
end

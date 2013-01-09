class AddSerializedHashToAnalyticsCaches < ActiveRecord::Migration
  def change
    add_column :analytics_caches, :hash_data, :text
  end
end

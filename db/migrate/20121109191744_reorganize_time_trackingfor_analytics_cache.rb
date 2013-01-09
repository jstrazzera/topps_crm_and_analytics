class ReorganizeTimeTrackingforAnalyticsCache < ActiveRecord::Migration
  def up
  	change_column :analytics_caches, :time, :time
  	add_column :analytics_caches, :date, :date
  end

  def down
  	change_column :analytics_caches, :time, :datetime
  	remove_column :analytics_caches, :date
  end
end

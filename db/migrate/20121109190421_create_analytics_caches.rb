class CreateAnalyticsCaches < ActiveRecord::Migration
  def change
    create_table :analytics_caches do |t|
      t.string :kind
      t.datetime :time
      t.integer :int_data

      t.timestamps
    end
  end
end

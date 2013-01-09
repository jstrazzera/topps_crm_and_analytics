class CreateAbTestCaches < ActiveRecord::Migration
  def change
    create_table :ab_test_caches do |t|
      t.string :test_name
      t.string :app
      t.integer :fan_id
      t.string :group
      t.boolean :success

      t.timestamps
    end
  end
end

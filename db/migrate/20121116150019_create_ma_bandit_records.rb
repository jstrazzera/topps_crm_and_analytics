class CreateMaBanditRecords < ActiveRecord::Migration
  def change
    create_table :ma_bandit_records do |t|
      t.integer :ma_bandit_id
      t.integer :fan_id
      t.boolean :success
      t.string :group

      t.timestamps
    end
  end
end

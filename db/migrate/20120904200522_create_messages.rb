class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.boolean :attempted
      t.boolean :success
      t.string :type
      t.string :message
      t.string :batch_id

      t.timestamps
    end
  end
end

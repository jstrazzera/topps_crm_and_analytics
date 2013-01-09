class CreateMaBandits < ActiveRecord::Migration
  def change
    create_table :ma_bandits do |t|
      t.string :name
      t.string :app
      t.string :groups
      t.datetime :start_date
      t.datetime :end_date
      t.text :results

      t.timestamps
    end
  end
end

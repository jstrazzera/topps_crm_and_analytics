class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :color
      t.string :name
      t.string :city
      t.datetime :promo_start_date
      t.datetime :promo_end_date

      t.timestamps
    end
  end
end

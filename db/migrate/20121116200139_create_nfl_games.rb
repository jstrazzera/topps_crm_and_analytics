class CreateNflGames < ActiveRecord::Migration
  def change
    create_table :nfl_games do |t|
      t.integer :team_1_id
      t.integer :team_2_id
      t.datetime :game_start

      t.timestamps
    end
  end
end

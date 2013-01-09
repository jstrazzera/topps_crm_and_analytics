class NflGame < ActiveRecord::Base
  attr_accessible :game_start, :team_1_id, :team_2_id

  def team_1
  	NflTeam.find_by_id team_1_id
  end

   def team_2
  	NflTeam.find_by_id team_2_id
  end

end

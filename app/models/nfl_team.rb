class NflTeam < RemoteTableModel
  has_many :huddle_fans, primary_key: "name", foreign_key: "favorite_team"
  has_many :fans, through: :huddle_fans	
  has_many :nfl_players, foreign_key: "team_id" 
  has_many :nfl_games

  #accessed through method_missing, below
  def this_teams_top_players(number_of_players)
  	nfl_players.order(:points).last(number_of_players)
  end

  def method_missing(meth, *args, &block)
  	puts meth.to_s
    puts (meth.to_s  =~ /top_[0-9]_players/)
  	if meth.to_s =~ /top_[0-9]_players/
  		arg = meth.to_s.match(/[0-9]/).to_s.to_i
  		puts "arg is #{arg}"
  		this_teams_top_players(arg)
  	else
  		super
  	end

  end

  def playing_today?
    today_range = (Date.today.beginning_of_day)..(Date.today.end_of_day)
    NflGame.where(game_start: today_range).where("team_1_id = #{id} OR team_2_id = #{id}").exists?
  end

  def playing_tomorrow?
    tomorrow_range = (Date.tomorrow.beginning_of_day)..(Date.tomorrow.end_of_day)
    NflGame.where(game_start: tomorrow_range).where("team_1_id = #{id} OR team_2_id = #{id}").exists?
  end
end
class Team < ActiveRecord::Base
  attr_accessible :city, :color, :name, 
  :promo_end_date, :promo_start_date

  has_many :mailing_list_emails

	def self.team_hash2
		{"LAA"=>"angels",
 		"HOU"=>"astros",
 		"OAK"=>"athletics",
 		"PHA"=>"as",
 		"MIL"=>"brewers",
 		"SLA"=>"browns",
 		"STL"=>"cardinals",
 		"HOC"=>"colts",
 		"CHC"=>"cubs",
 		"ARI"=>"diamondbacks",
 		"LAD"=>"dodgers",
 		"SFG"=>"giants",
 		"CLE"=>"indians",
 		"SEA"=>"mariners",
		"FLA"=>"marlines",
 		"NYM"=>"mets",
 		"WSN"=>"nationals",
 		"BAL"=>"orioles",
 		"SDP"=>"padres",
 		"PHI"=>"phillies",
 		"PIT"=>"pirates",
 		"TEX"=>"rangers",
 		"TBR"=>"rays",
 		"BOS"=>"red_sox",
 		"CIN"=>"reds",
 		"COL"=>"rockies",
 		"KCR"=>"royals",
 		"DET"=>"tigers",
 		"MIN"=>"twins",
 		"CHW"=>"white_sox",
 		"NYY"=>"yankees",
 		"ATL"=>"braves",
 		"TOR"=>"blue_jays",
 		#these are because woody and ernesto are dumb and use non-standard abbreviations for no reason
 		"ANA" => "angels",
 		"CWS" => "white_sow",
 		"KAN" => "royals",
 		"LOS" => "dodgers",
 		"MIA" => "marlins",
 		"TAM" => "rays",
 		"WAS" => "nationals"}
	end






end

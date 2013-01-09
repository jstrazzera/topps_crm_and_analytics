class NflCollection < RemoteTableModel
	has_one :nfl_player, primary_key: "player", foreign_key: "id"
	belongs_to :fan, foreign_key: "fan"



end
class MlbCollection < RemoteTableModel
	has_one :mlb_player, primary_key: "player", foreign_key: "id"


  def get_fan
		Fan.find_by_id self.fan
	end


end
class MlbNews < RemoteTableModel
  self.inheritance_column = nil
	
  
	
  def player
    MlbPlayer.find_by_first_name_and_last_name(self.player_name.split[0], self.player_name.split[-1])
  end
end
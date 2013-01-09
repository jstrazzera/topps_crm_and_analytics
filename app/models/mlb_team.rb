class MlbTeam < RemoteTableModel
  has_many :fans, primary_key: "name", foreign_key: "favorite_team"	
  def db_team
  	Team.find_by_name name.downcase.gsub(" ", "_")
  end
end
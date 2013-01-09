class NflPlayer < RemoteTableModel
  has_one :nfl_team, foreign_key: :name, primary_key: :team_name

end
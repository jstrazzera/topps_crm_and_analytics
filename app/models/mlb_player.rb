class MlbPlayer < RemoteTableModel
  has_one :mlb_team, foreign_key: :alias, primary_key: :team_alias

end
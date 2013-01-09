class MlbBlurb < ParentBlurb
	has_one :player, class_name: "MlbPlayer", primary_key: "player_id", foreign_key: "id"

end
class NflBlurb < ParentBlurb
	has_one :player, class_name: "NflPlayer", primary_key: "player_id", foreign_key: "id"








end
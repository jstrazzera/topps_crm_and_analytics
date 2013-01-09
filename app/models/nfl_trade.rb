class NflTrade < ParentTrade
	def self.player_class
		NflPlayer
	end
	player_assosciations player_class.to_s
	#player_associations("NflPlayer")
	# belongs_to :to_fan, class_name: "Fan", primary_key: "fan_name", foreign_key: "to_fan_name"
	# belongs_to :from_fan, class_name: "Fan", primary_key: "fan_name", foreign_key: "from_fan_name"

	# has_one :to_player, class_name: "NflPlayer", primary_key: "to_player_id", foreign_key: "id"
	# has_one :from_player, class_name: "NflPlayer", primary_key: "from_player_id", foreign_key: "id"





end
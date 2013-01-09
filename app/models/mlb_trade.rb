class MlbTrade < ParentTrade
	def self.player_class
		MlbPlayer
	end
		has_one :to_player, class_name: MlbPlayer.to_s, primary_key: "to_player_id", foreign_key: "id"
		has_one :from_player, class_name: MlbPlayer.to_s, primary_key: "from_player_id", foreign_key: "id"

	# belongs_to :to_fan, class_name: "Fan", primary_key: "fan_name", foreign_key: "to_fan_name"
	# belongs_to :from_fan, class_name: "Fan", primary_key: "fan_name", foreign_key: "from_fan_name"

	# has_one :to_plyaer, class_name: "MlbPlayer", primary_key: "to_player_id", foreign_key: "id"
	# has_one :from_player, class_name: "MlbPlayer", primary_key: "from_player_id", foreign_key: "id"

	def user1
		Fan.find_by_fan_name self.to_fan_name
	end

	def user2
		Fan.find_by_fan_name self.from_fan_name
	end

	def player1
		MlbPlayer.find_by_id self.to_player_id
	end

	def player2
		MlbPlayer.find_by_id self.from_player_id
	end
end
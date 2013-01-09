class ParentTrade < RemoteTableModel
	self.abstract_class = true
	
	belongs_to :to_fan, class_name: "Fan", primary_key: "fan_name", foreign_key: "to_fan_name"
	belongs_to :from_fan, class_name: "Fan", primary_key: "fan_name", foreign_key: "from_fan_name"

	#subclass must define player_class
	def self.player_assosciations(player_class)
		has_one :to_player, class_name: player_class, primary_key: "to_player_id", foreign_key: "id"
		has_one :from_player, class_name: player_class, primary_key: "from_player_id", foreign_key: "id"
	end

	






end
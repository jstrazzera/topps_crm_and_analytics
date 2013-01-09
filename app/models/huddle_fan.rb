class HuddleFan < ParentFan
	set_table_name "huddle_profiles"
	establish_connection(
      :adapter  => 'mysql2',
      :host     => "bunt.c76vwj0m73zb.us-east-1.rds.amazonaws.com",
      :username => "magz",
      :password => "roebling909",
      
      :database => "bunt",
      :port     => 3306
    )
    def self.trade_class()	NflTrade end
    def self.team_class()	NflTeam  end
    def self.blurb_class()	NflBlurb end
    def self.player_class() NflPlayer end
    def self.app() "huddle" end
    	

	belongs_to :fan

	# has_many :nfl_collections, foreign_key: "fan"
 	# has_many :nfl_players, through: :nfl_collections
	has_one :favorite_team, class_name: team_class.to_s, primary_key: "favorite_team", foreign_key: "name"
    has_many :login_logs, through: :fan

    has_many :trades_offered, class_name: "NflTrade", foreign_key: "from_fan_id", primary_key: "fan_id"
    has_many :trades_offered_to, class_name: "NflTrade", foreign_key: "to_fan_id", primary_key: "fan_id" 

    def nfl_collections
    	NflCollection.where(fan: fan.id)
    end

    def nfl_players
		ids = nfl_collections.pluck(:player)
    	NflPlayer.where("id IN (?)", ids)
    end

	def email
		Fan.find(fan_id).email
	end

	#ITS ME!
	def self.magz
		Fan.find_by_fan_name "MMAGZ"
	end

	def fan_name
		fan.fan_name
	end

	def apns_device
		ApnsDevice.find_by_deviceuid deviceuid
	end

	def unsubscribe_link_address
		"http://api.toppsbunt.com/huddle/notification/unsubscribe?id=" + fan.id_argument
	end

	def purchase_card_promo_push
		purchases = Purchase.where("fan_id = #{id}")
		if purchases.count > 0
			unless purchases.any? {|p| p.pack =~ /FavTeam/}
				send_push "purchase_card_promo", {template_version: "bought_a"}
			end
		else
			send_push "purchase_card_promo", {template_version: "not_bought_a"}
		end

	end

	def self.fans_with_one_player_from_a_team(name)
			fans = []
			player_ids = NflPlayer.where("team_name like '#{name}'").pluck(:id)
			player_ids.each do |p|
				fans << NflCollection.where("player = #{p}").pluck(:fan).uniq
			end
		fans.flatten.uniq

	end

	def created_date
		Date.strptime(created.to_s, "%s")
	end

	def logged_in_after_x_days(num_of_days)
		DateTime.strptime(created.to_s, "%s") + num_of_days.days < last_visited 
	end

	def push_test(kind)
		case kind
			when 'joined'
				send_push "joined", "of_fan"=>Fan.find_by_fan_name("WOODY").id
			when 'offer', 'accept'
				send_push kind, "trade_id"=>NflTrade.last.id
			when 'player_news'
				send_push "player_news", "blurb_id"=>NflBlurb.last.id
		end
	end
	def verified
		fan.verified
	end
	
	def self.casey
		Fan.find_by_fan_name("OMNOMNINJA").huddle_fan

	end

	
end
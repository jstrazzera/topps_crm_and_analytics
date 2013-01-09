class ParentFan < RemoteTableModel
	self.abstract_class = true



	[:setting_email,
	:setting_facebook,
	:setting_alert,

	:setting_twitter,
	:setting_email,
	:setting_facebook,

	:email_my_player_news,
	:email_my_favorite_team,
	:email_my_friends_joined,

	:apns_my_player_news,
	:apns_my_favorite_team,
	:apns_my_friends_joined,

	:verified].each do |attrib|
		define_method attrib do
			check_bool(attrib.to_s)
		end
	end

	def check_bool(attr_name)
		attributes[attr_name] == "yes"
	end

	#all emails EXCEPT verify....separarte funciton for now
	def send_email(kind, opts={})
		puts kind
		puts app
		puts id
		begin
			if kind == "welcome" && app == "huddle" 
				create_delayed_drip_pushes
			end
		rescue
			puts "SOMETING WENT WRONG WITH MULTI ARMED BANDIT!!!"
		end
		if email && wants_email?(kind) && !too_old?(kind, opts)
			sent = false
			info = template_hash(kind, opts)
			
			opts[:template_version] ||= "default" 
			template = Template.find_by_target_and_app_and_version(kind + "_email", app, opts[:template_version])
			
			unless BlackListedEmail.find_by_address email
				if template
					email_subject = ERB.new(template.subject).result(binding).strip
					email_body = ERB.new(template.body).result(binding).strip
					header={"X-SMTPAPI"=>{'category'=>app + "_" + kind}.to_json}
					Pony.mail(to: self.email, html_body: email_body, subject: email_subject, from: "#{app.upcase}@topps.com", headers: header)
					puts "email sent to #{self.email} of kind #{kind}...#{app}"
					sent = true
				else
					puts "NO TEMPLATE FOUND #{kind} #{opts.to_s}"
				end
				begin
					MessageLog.create(method: "email", kind: kind, fan_id: id, data: opts.to_s, app: app, version: opts[:template_version], sent: sent)
				rescue
					puts "error in message log: #{$!.to_s}, #{app}"
					puts "#{id} ----------------- #{opts.to_s}"
				end
			end
	
		end
	end


	#apns must be defined for this to work
	def send_push(kind, opts={})
		sent = false
		if apns_device && wants_push?(kind)	&& !too_old?(kind, opts)
			
			#this is the info that's used to fill out the template
			info = template_hash(kind, opts)
			if app == "huddle" && kind == "offer"
				if info["trade"]["to_trade_points"] > 0
					opts[:template_version] = "worse_player"
				else
					opts[:template_version] = "better_player"
				end
			end
			opts[:template_version] ||= "default" 
			template = Template.find_by_target_and_app_and_version(kind + "_push", self.class.app, opts[:template_version])
			if template

# Key		Value			Action
# p		<player id>		Opens the player's profile and flips to news
# f		<fan name>		Opens the fan's profile
# h		""				Goes to home screen
# l		""				Goes to leaderboard
# c		""				Goes to players (cards)
# t		""				Goes to trades screen (not for huddle)

				if app == "bunt"
					deep_link_value = case kind
										when "player_news" 
											#need to fix and test this line
											{"p"=>info["player1"]["id"]}
										when "joined"
											{"f"=>info["user2"]["fan_name"]}
										when "offer"
											{"f"=>info["user1"]["fan_name"]}
										when "accept"
											{"h"=>"-"}
										else 
											{"f"=>info["user1"]["fan_name"]}
										end
				elsif app == "huddle"
					deep_link_value = case kind
										when "player_news"
											{"p"=>info["player1"]["id"].to_s}
										when "joined"
											{"f"=>info["user2"]["fan_name"]}
											{"h"=>"x"}
										when "offer"
											{"h"=>"x"}
										when "accept"
											{"p"=>info["from_player"]["id"]}
										when /new_card/
											{"thstore"=>"x"}
										else 
											nil
										end
				end

					
				push_data = {"aps"=>{
								"alert"=>{
									"action-loc-key"=>"GO",
									
									"body"=>ERB.new(template.body).result(binding).strip
										},
								"sound"=>"to.caf"
									}

							}
				if deep_link_value
					if app == "bunt"
						push_data.update("o"=>deep_link_value)
					elsif app == "huddle"
						push_data.update("p"=>deep_link_value)
					end

				end
				puts push_data
				if kind == "offer"
					push_data.update("trade"=> {"to_fan"=>info["to_fan"]["fan_name"]})
				elsif kind == "accept"
					push_data.update("trade"=> {"from_fan"=>info["from_fan"]["fan_name"]})
				end

			#gotta be base64 and in the other hash format for the server to process it properly
				push_data = Base64.encode64(push_data.to_s.gsub("=>", ":"))
				push_params = {"development"=>apns_device.development, "devicetoken"=>apns_device.devicetoken, "data"=>push_data, "app"=>self.class.app}
				
				x = Net::HTTP.post_form(URI.parse("http://cycle.toppsbunt.com/api/send_apns"), push_params)
				puts x.body
				puts "push sent to user " + fan_name
				sent = true
			else
				puts "NO TEMPLATE FOUND"
			end
			begin
				MessageLog.create(method: "push", kind: kind, fan_id: id, app: app, sent: sent, version: opts[:template_version])
			rescue
				puts "error in message log: #{$!.to_s}"
			end



		end
	end

	def template_hash(kind, opts={})
		result={"user1"=>attributes}
		result["user1"].update("fan_name"=>fan_name)
		if favorite_team
			result.update("team_hash"=>favorite_team.attributes)
			if self.class.app == "bunt"
				result["team_hash"].update(favorite_team.db_team.attributes)
			end
		end
		if opts[:extra] then result.update({"extra"=>opts[:extra]}) 
			
		end
	
		case kind
			when "offer", "accept"
				trade = self.class.trade_class.find opts["trade_id"]

				result["to_fan"] = trade.to_fan.attributes
				result["from_fan"] = trade.from_fan.attributes
				
				result["trade"] = trade.attributes
				result["to_player"] = trade.to_player.attributes
				result["from_player"] = trade.from_player.attributes

				d=Time.at(trade.expiration).to_datetime			
				result["trade"]["expiration"] = {"date"=>d.strftime("%F"), "time"=>d.strftime("%I:%M %p")}
			when "welcome"
			when "joined"
				#does this work????
				result["user2"] = Fan.find(opts["of_fan"]).attributes
			when "player_news"
				blurb = self.class.blurb_class.find(opts["blurb_id"])
				result["blurb"] = blurb.attributes
				result["player1"] = blurb.player.attributes
			when "welcome_drip"
				result["top_fan"] = HuddleFan.order(:points_this_week).last.attributes
				result["top_fan"].update({"fan_name"=>HuddleFan.order(:points_this_week).last.fan_name})
			when /sit_start/
				puts "in here"
				if opts["player1_id"]
					result["player1"] = self.class.player_class.find(opts["player1_id"]).attributes
					puts result["player1"]
					puts "-------"
				end
		end
		result
	end
	def wants_push?(kind, opts={})
		case kind
			when "welcome"
				false
			when "joined"
				apns_my_friends_joined 
			# when "welcome_drip"
			# 	if opts[:template_version] == "a"
			# 		(last_visited + 2.days < Time.now)
			# 	elsif opts[:template_version] =~ /b/
			# 		true
			# 	else
			# 		false
			# 	end
			else
				setting_alert

		end



	end

	def wants_email?(kind)
		case kind
			when "welcome", "verify", "promo"
				true
			when "joined"
				email_my_friends_joined 
			when "offer", "accept"
				setting_email 
			when "player_news"
				email_my_player_news
			else 
				true
		end


	end

	def app
		self.class.app
	end

	#this is just for testing
	def send_all_pushes
		send_push "offer", {"trade_id"=> NflTrade.where("to_trade_points > 0").last.id}
		send_push "offer", {"trade_id"=> NflTrade.where("to_trade_points < 0").last.id}

		send_push "accept", {"trade_id"=> NflTrade.last.id}
		send_push "player_news", {"blurb_id"=> NflBlurb.last.id}
		send_push "joined", {"of_fan"=>HuddleFan.last.id}

	end

	def send_all_emails
		send_email "welcome"
		send_email "offer", {"trade_id"=> NflTrade.where("to_trade_points > 0").last.id}
		send_email "offer", {"trade_id"=> NflTrade.where("to_trade_points < 0").last.id}
		send_email "accept", {"trade_id"=> NflTrade.last.id}
		send_email "joined", {"of_fan"=>HuddleFan.last.id}

	end

	def too_old?(kind, opts={})
		case kind 
			when "offer", "accept"
				trade = self.class.trade_class.find_by_id opts["trade_id"]
				if (trade && (DateTime.strptime(trade.expiration.to_s, "%s") < DateTime.now))
					if trade
						puts "TRADE #{opts["trade_id"].to_s} is TOO OLD!"
					else
						puts "TRADE NOT FOUND"
					end
				end
				(trade && (DateTime.strptime(trade.expiration.to_s, "%s") < DateTime.now))
			# when "player_news"
			# 	blurb = 
			else
				false
		end

	end

	def create_delayed_drip_pushes(assigned_group=nil)
		puts "CREATING DELAYED DRIP PUSHES"
		case (assigned_group || MaBandit.which_to_perform?("welcome_drip_push_test_1", "huddle", id))
			when "a"
				schedule_time = Date.today.to_datetime + 3.days + 13.hours
				delay(run_at: schedule_time).send_push("welcome_drip", {template_version: "a"})
				puts "GROUP A, PUSH SCHEDULED FOR #{(schedule_time).to_s}"
			when "b"
				[1,3,5].each do |x|
					schedule_time = Date.today.to_datetime + x.days + 13.hours
					delay(run_at: schedule_time).send_push("welcome_drip", {template_version: "b" + x.to_s})
					puts "GROUP B, PUSH SCHEDULED FOR #{(schedule_time).to_s}"
				end
			when "control"
				puts "CONTROL GROUP NO PUSHES SCHEDULED"
			else
				puts "SOMETHING WENT WRONG WITH MaBandit"


		end

	end
end






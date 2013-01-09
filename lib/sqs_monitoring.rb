require "open-uri"


module SqsMonitoring
	
	def monitor_sqs(app)
		feed_name = "#{app}_messages"

		sqs = AWS::SQS.new(acess_key: ['aws_access_key_id'], secret_access_key: ENV['aws_secret_access_key'])
		messages_queue = sqs.queues["xxxxxx/#{feed_name}"]

		messages_queue.poll do |m|
			decoded_body=JSON.parse(Base64.decode64 m.body)
			
			begin
				process_sqs_item(decoded_body, app)
			rescue
				Pony.mail(to: "michael.magner@gmail.com", from: "ERROR_in_#{app}_queue@topps.com", subject: Time.now.to_s, body: $!.to_s)
				put_back_in_queue(decoded_body, app)
			end
		end

	end
	def process_sqs_item(message, app)
		puts message
		# begin
			case message["kind"]
				when "player_news"
					if app == "bunt"
						send_bunt_news_messages message["blurb_id"]
					elsif app == "huddle"
						send_huddle_news_messages message["blurb_id"]
					end
						
				when "verify"
					fan=Fan.find_by_id(message["user_id"])
					if fan && fan.email
						fan.send_verify_email
					else
						put_back_in_queue(message, app)
					end
				else
					if app == "huddle"
						fan=Fan.find_by_id(message["user_id"])
					elsif app == "bunt"
						fan=Fan.find_from_queue_json message
					end
					if fan
						if app == "bunt"
							fan.delay.send_email(message["kind"], message)
							fan.delay.send_push(message["kind"], message)

						elsif app == "huddle" && fan.huddle_fan
							fan.huddle_fan.delay.send_email(message["kind"], message)
							fan.huddle_fan.delay.send_push(message["kind"], message)
						end
					else
						put_back_in_queue(message, app)
					end
				end
		# rescue

		# end
	end

	def send_huddle_news_messages(blurb_id)
 		puts "new news item!"
		
		blurb = NflBlurb.find blurb_id
		if blurb && (blurb.time_realpub < DateTime.now - 1.days)
			begin
				Pony.mail(to: ["michael.magner@gmail.com"], html_body: "blurb_id: #{blurb.id}", subject: "old news story", from: "huddle")
			rescue
			end
		end
		if blurb && blurb.player && (blurb.time_realpub > DateTime.now - 1.days)
			# player_news_push_fans = HuddleFan.joins(:nfl_players).where("nfl_players.id = #{blurb.player.id}").where("huddle_profiles.apns_my_player_news like 'yes'").pluck("huddle_profiles.id")
			player_news_push_fans = []
			team_news_push_fans = HuddleFan.joins(:favorite_team).where("nfl_teams.id  = #{blurb.player.team_id}").where("huddle_profiles.apns_my_favorite_team like 'yes'").pluck("huddle_profiles.id")
			
			sent_devices = []
			(player_news_push_fans | team_news_push_fans).each do |fan_id|
				fan = HuddleFan.find_by_id fan_id
					if fan 
						if fan.apns_device && (!sent_devices.include? fan.apns_device.id)
							puts "sending news story"
							fan.delay.send_push("player_news", "blurb_id"=>blurb.id)
							sent_devices << fan.apns_device.id
						else
							puts "no device or device already sent to"
						end
					else
						puts "that fan wasn't found..."
					end
			end
			Pony.mail(to: ["michael.magner@gmail.com", "mbramlage@topps.com", "cvacarro@topps.com"], html_body: "push fans = #{(player_news_push_fans | team_news_push_fans).count}\n
														#{blurb.headline}", subject: "new news story sent", from: "huddle")

			#this was in an effort to close up a memory leak
			#i'm not sure if it was either neeeded or affected (i moved these processes to procfile ones rather than rake)
			#but i don't have any strong reason to take it out, so it's here still
			[team_news_push_fans, player_news_push_fans, sent_devices].each {|x| x = nil}
		end
	end

	def send_bunt_news_messages(blurb_id)
		blurb = MlbBlurb.find blurb_id
		if blurb && blurb.player && (blurb.published_date > DateTime.now - 1.days)
			#disablet his when we go to digest for bunt
			player_news_email_fans = Fan.joins(:mlb_players).where("mlb_players.id = #{blurb.player.id}").where("fans.email_my_player_news like 'yes'").pluck("fans.id")
			team_news_email_fans = Fan.where("favorite_team like '#{MlbTeam.find(blurb.player.team_id).name}' AND email_my_favorite_team like 'yes'").pluck("fans.id")
						
			player_news_push_fans = Fan.joins(:mlb_players).where("mlb_players.id = #{blurb.player.id}").where("fans.apns_my_player_news like 'yes'").pluck("fans.id")
			team_news_push_fans = Fan.where("favorite_team like '#{MlbTeam.find(blurb.player.team_id).name}' AND apns_my_favorite_team like 'yes'").pluck("fans.id")

			sent_devices = []
			(player_news_push_fans | team_news_push_fans).each do |fan_id| 
				fan = Fan.find fan_id
				if fan && fan.apns_device 
					if !sent_devices.include? fan.apns_device.id
						sent_devices << fan.apns_device.id
						fan.delay.send_push("player_news", "blurb_id"=> blurb_id)
					end

				end
						end
						(player_news_email_fans | team_news_email_fans).each do |id| 
							fan = Fan.find id
							puts "here"
							if fan && fan.email 
								puts "setting reddis"
								fan.delay.send_email("player_news", "blurb_id"=> blurb_id)
							end
						end
						begin 
							Pony.mail(to: ["michael.magner@gmail.com", "mbramlage@topps.com"], html_body: "email fans = #{(player_news_email_fans | team_news_email_fans).count.to_s}\n
																				push fans = #{(player_news_push_fans | team_news_push_fans).count}\n
																				json = #{json.to_s}", subject: "new news story sent", from: "magz")
						rescue
						end
						#trying some stuff for garbage colleciton purposes
						[player_news_email_fans, team_news_email_fans, player_news_push_fans, team_news_push_fans, sent_devices].each {|x| x=nil}

		end
	end

	def send_news_pushes(app, id_array, blurb_id)

	end

	def retry_log_flag(attempts)
		2.times {puts "*******************"}
		puts "this is the #{attempts} retry"
		2.times {puts "*******************"}
	end

	def put_back_in_queue(message, app)
		feed_name = "#{app}_messages"

		sqs = AWS::SQS.new(acess_key: ['aws_access_key_id'], secret_access_key: ENV['aws_secret_access_key'])
		messages_queue = sqs.queues["xxxxxxxx/#{feed_name}"]


		if message["retry"]
			retries = message["retry"] + 1
		else
			retries = 1
		end
		puts retries
		puts "******************"
		if retries > 20
			Pony.mail(to: "michael.magner@gmail.com", html_body: "our of retries...not good" + message.to_s, subject: "out of retries", from: "crm_server_error@topps.com")
		else
			message.update("retry"=>retries)
			messages_queue.delay(run_at: Time.now + 1.minute).send_message(Base64.encode64(message.to_s.gsub("=>", ":")))
		end
	end

end
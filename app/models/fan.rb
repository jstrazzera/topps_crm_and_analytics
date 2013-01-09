class Fan < ParentFan

    # has_one :apns_device, foreign_key: "deviceuid", primary_key: "deviceuid"

    def self.trade_class()	MlbTrade end
    def self.team_class()	MlbTeam  end
    def self.blurb_class()	MlbBlurb end
 	def self.player_class() MlbPlayer end

    def self.app() "bunt" end

    has_many :mlb_collections, foreign_key: "fan"
    has_many :mlb_players, through: :mlb_collections
    has_many :login_logs, primary_key: "id", foreign_key: "fan_id"
    has_one :huddle_fan
    has_many :received_trades, class_name: "MlbTrade", primary_key: "fan_name", foreign_key: "to_fan_name"
    has_many :offered_trades, class_name: "MlbTrade", primary_key: "fan_name", foreign_key: "from_fan_name"
	has_one :favorite_team, class_name: team_class.to_s, primary_key: "favorite_team", foreign_key: "name"
	

    def send_verify_email
		begin
			unless verified
				email_subject = "Confirm your Topps HUDDLE Account"
				email_body = "Hey #{fan_name}, <br><br>Thanks for joining Topps HUDDLE! It should be one exhilarating experience. Trust us, we know, we built the app.<br><br>
				Please click this link to confirm your email address: <br><a href='http://api.toppsbunt.com/huddle/verify/email?verifycode=#{verifycode}'>http://api.toppsbunt.com/huddle/verify/email?verifycode=#{verifycode}</a><br><br>
				It may take a few minutes to activate your ability to trade. To speed it up, go to your HOME screen and pull-to-refresh or try closing and re-opening the app.
				"
				kind_for_log =  "verify"
			else
				email_body = "Hey #{fan_name}, <br><br>
				You've already verified your account so get in the game and win!<br><br>
				It may take a few minutes for our system to activate your ability to trade. Closing and re-opening the app may help this process along."
				email_subject = "Your Topps HUDDLE Account is Confirmed!"
				header={"X-SMTPAPI"=>{'category'=>app + "_" + "already_verified"}.to_json}
				kind_for_log = "already_verified"
			end
				header={"X-SMTPAPI"=>{'category'=>app + "_" + kind_for_log}.to_json}

				puts Pony.mail(to: email, html_body: email_body, subject: email_subject, from: "huddle@topps.com", headers: header)
				begin
					MessageLog.create(method: "email", kind: kind_for_log, fan_id: id, app: app)
				rescue
					puts "error in message log: #{$!.to_s}, #{app}"
				end

				puts "email sent to #{email} of kind #{kind_for_log}"
				# begin
				# 	if id % 2 == 0
				# 		# delay.send_drip_email(1)
				# 	else
				# 		puts "odd numbered id...no email send"
				# 	end
				# rescue
				# 	puts "there was a problem quueing drip verify emails"
				# end
		rescue
			Pony.mail(to: "michael.magner@gmail.com", from: "VERIFY_ERROR@topps.com", subject: Time.now.to_s, body: "#{$!.to_s} /n #{$!.backtrace.to_s}")
		end
    end
   	

    # def send_drip_email(days_since_joined)
    # 	unless verified || !email
    # 		email_subject = "Confirm Your Topps HUDDLE Account"
	   #  	email_body =  "Hey #{fan_name}!<br><br>
	   #  	We noticed you still haven't verified your email. <br>
	   #  	Please be sure to click on the verification link below so you can do cool stuff like unlock trading!<br><br>
	   # 		<a href='http://api.toppsbunt.com/huddle/verify/email?verifycode=#{verifycode}'>http://api.toppsbunt.com/huddle/verify/email?verifycode=#{verifycode}</a><br><br>
	   #  	It may take a few minutes for our system to activate your ability to trade. Closing and re-opening the app may help this process along."
	   #  	kind_for_log = "drip_verify_#{days_since_joined.to_s}"
	   #  	header={"X-SMTPAPI"=>{'category'=>app + "_" + kind_for_log}.to_json}
    # 		puts Pony.mail(to: email, html_body: email_body, subject: email_subject, from: "huddle@topps.com", headers: header)
    # 		begin
    # 			MessageLog.create(method: "email", kind: kind_for_log, fan_id: id, app: app)
    # 			unless days_since_joined >= 5
    # 				delay(run_at: Date.today + 51.hours).send_drip_email(days_since_joined + 2)
    # 			end
    # 		rescue
    # 			puts "something wrong with either message log creation or queing another drip"
    # 		end
    # 	end
    # end
	#this is for the bunt sqs feed because it doesn't contain the user_id field that huddle does
	#sux but watcha gonna do
	def self.find_from_queue_json(json)
		case json["kind"]
			when "offer"
				trade = MlbTrade.find_by_id(json["trade_id"])
				trade ? trade.to_fan : nil
			when "accept"
				trade = MlbTrade.find_by_id(json["trade_id"])
				trade ? trade.from_fan : nil
			when "welcome"
				Fan.find_by_id json["fan_id"]
			when "joined"
				Fan.find_by_id json["for_fan"]
			else
				nil				
		end
	end
	
	#ITS ME!
	def self.magz
		Fan.find_by_fan_name "MMAGZ"
	end

	def self.casey
		# Fan.find_by_fan_name "TANGDYNASTY"
		Fan.find_by_fan_name "OMNOMNINJA"
	end

	def unsubscribe_link_address
		"http://api.toppsbunt.com/notification/unsubscribe?id=" + id_argument
	end
	def id_argument
		Base64.encode64(id.to_s + ":" + created.to_s)
	end

	def apns_device
		ApnsDevice.find_by_deviceuid deviceuid
	end

end
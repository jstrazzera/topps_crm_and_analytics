	USER_KEYS = ["user_name", 
				"user_real_name", 
				"avatar", 
				"user_id", 
				"favorite_team", 
				"last_login"]
	TRADE_KEYS = ["message", 
				"traded_for_player_name",
				"traded_for_player_id",
				"traded_player_name", 
				"traded_player_id", 
				"trade_point_differential",
				"trade_expiration_date"]
	NEWS_KEYS = ["headline", 
				"player_name", 
				"player_id",
				"full_text"]


require "spec_helper"
require "digest/md5"

	USER1 = {"user1"=>{"user_name"=>"magz", "user_real_name"=>"michael magner", "avatar"=>"avatar-4-0", "user_id"=>5, "favorite_team"=>"yankees", "last_login"=>Date.today.to_s}}
	USER2 = {"user2"=>{"user_name"=>"trip", "user_real_name"=>"trip tate", "avatar"=>"avatar-4-0", "user_id"=>7, "favorite_team"=>"cardinals", "last_login"=>Date.today.to_s}}
	TRADE = {"trade"=>{"message"=>"please accept my trade", "player_name"=>"ichiro yamaguchi", "player_id"=> 60581, "trade_point_differential"=>200}}
	NEWS = {"news" => {"headline"=>"yamaguchi wins gold!", "player_name"=>"ichiro yamaguchi", "player_id"=> 60581}}


describe CrmController do
	describe "test posting" do
		it "takes in all email inputs properly" do
			[:welcome, :friend_joined, :trade_offer, :news].each do |x|
				queue_item = FactoryGirl.build x
				queue_item.has_valid_data?.should == true
				time=Time.new.gmtime.to_s[0..-5]
				email = "michael.magner@gmail.com"

				access_key_base = email + time + queue_item.data.to_json + ENV["CRM_SECRET_PHRASE"]
				puts access_key_base
				access_key = Digest::MD5.hexdigest(access_key_base)

				# post "/add_to_crm_queue/bunt/" + x.to_s, format: :json
				# puts response.body
				#post "add_to_crm_queue"
				response = post "create_queue_entry", app: "bunt", email_type: x.to_s, data: queue_item.data.to_json, email_address: email, access_key: access_key, time: time
				# puts x.to_s + " response is: " + response.body
				response.status.should == 201
			end
		end

	end
end
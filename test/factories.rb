# FactoryGirl.define do 
# 	USER1 = {"user1"=>{"user_name"=>"magz", "user_real_name"=>"michael magner", "user_avatar"=>"beards", "user_id"=>5, "favorite_team"=>"yankees", "last_login"=>Date.today.to_s}}
# 	USER2 = {"user2"=>{"user_name"=>"trip", "user_real_name"=>"trip tate", "user_avatar"=>"pigeon", "user_id"=>7, "favorite_team"=>"cardinals", "last_login"=>Date.today.to_s}}
# 	TRADE = {"trade"=>{"message"=>"please accept my trade", "player_name"=>"ichiro yamaguchi", "player_id"=> 60581, "trade_point_differential"=>200}}
# 	NEWS = {"news" => {"headline"=>"yamaguchi wins gold!", "player_name"=>"ichiro yamaguchi", "player_id"=> 60581}}

# 	factory :welcome, class: CrmQueueItem do 
# 		app  "bunt"
# 		destinaiton_email_address  "michael.magner@gmail.com"
# 		email_type  "welcome"
# 		data  USER1.to_json

# 	end

# 	factory :friend_joined, class: CrmQueueItem do 
# 		app  "bunt"
# 		destinaiton_email_address  "michael.magner@gmail.com"
# 		email_type  "friend_joined"
# 		data (USER1.merge USER2).to_json
# 	end

# 	factory :trade_offer, class: CrmQueueItem do 
# 		app  "bunt"
# 		destinaiton_email_address  "michael.magner@gmail.com"
# 		email_type  "trade_offer"
# 		data ((USER1.merge USER2).merge TRADE).to_json
# 	end

# 	factory :news, class: CrmQueueItem do 
# 		app  "bunt"
# 		destinaiton_email_address  "michael.magner@gmail.com"
# 		email_type  "news"
# 		data (USER1.merge NEWS).to_json
# 	end
 

# end
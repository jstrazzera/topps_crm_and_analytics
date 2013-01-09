desc "send set start reminders"
task :send_sit_start_reminders => :environment do 
	teams_playing_today = NflTeam.select(&:playing_today?)
	teams_playing_today_names = NflTeam.select(&:playing_today?).map(&:name)
	# teams_playing_today_names = ["Chiefs"]

	# best_player_playing_today = lambda do |fan|
	# 		fan_players = fan.nfl_collections.sort {|x,y| y.nfl_player.points <=> x.nfl_player.points}
	# 		best_player_playing_today_for_this_fan = fan_players.select {|x| teams_playing_today_names.include? x.team_name} .first
	# end

	# HuddleFan.all.each do |fan|
	puts "are there any teams playing today?"
	if teams_playing_today
		puts "yes, there are!"
		HuddleFan.for_all do |fan|

			puts "check out #{fan.id}"
			# case MaBandit.which_to_perform?("sit_start_test1", "huddle", fan.id)
			# 	when "general"
			# 		fan.delay(run_at: run_time).send_push("sit_start_reminder_1", {template_version: "general"})
			# 	when "customized_by_team"
			# 		best_player_to_send_about = best_player_playing_today.call(fan)
			# 		if best_player_to_send_about
			sitting_player = fan.nfl_collections.where(is_starting: "no").joins(:nfl_player).where("nfl_players.team_name IN (?)", teams_playing_today_names).first
			if sitting_player
				puts "eligible player, writing delayed job"
				sitting_player = sitting_player.nfl_player
				game = NflGame.where(game_start: Date.today.beginning_of_day..Date.today.end_of_day).where("team_1_id = '#{sitting_player.nfl_team.id}' OR team_2_id = '#{sitting_player.nfl_team.id}'").first
				run_time = game.game_start - 2.hours
				puts "here"
				fan.delay(run_at: run_time).send_push("sit_start_reminder_1", 
							{template_version: "customized_by_team",
							"player1_id"=> sitting_player.id})
				puts "delayed"
			else
				puts "nope"
			end
			# 		end

			# 	when "customized_by_player"
					# best_player_to_send_about = best_player_playing_today.call(fan)
					# if best_player_to_send_about
					# 	fan.delay(run_at: run_time).send_push("sit_start_reminder_1", 
					# 				{template_version: "customized_by_player",
					# 				extra: {"best_player"=> best_player_to_send_about.attributes}})
					# end

			# 	when "control"
			# 		#do nothing	
			# end
		end	
	end
end


# fan_list = HuddleFan.fans_with_one_player_from_a_team("Saints") | HuddleFan.fans_with_one_player_from_a_team("Falcons")


# fan_list.each do |f|
# 	fan = Fan.find_by_id(f).huddle_fan
# 	if fan
# 		player = nil
# 		if fan.nfl_collections.any? {|c| c.nfl_player.team_name == "Saints"}
# 			player = 1769
# 		elsif fan.nfl_collections.any? {|c| c.nfl_player.team_name == "Falcons"}
# 			player = 937
# 		end

# 		if player 
# 			fan.delay(run_at: DateTime.now.beginning_of_day + 18.hours).send_push("sit_start_reminder_1", 
# 			{template_version: "customized_by_team", "player1_id" => player})
# 		end
# 	else
# 		puts "SOMETHING WRONG #{f} NOT FOUND"
# 	end

# end

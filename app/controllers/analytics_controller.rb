class AnalyticsController < ApplicationController

	before_filter :check_login

	def huddle_monitor

	end


	def monitor
		default_graph_size = '400x400'

		@push_notifications = []
		@emails = []
		@new_users = []
		@daily_trade_offers = []
		@daily_trade_accepts = []
		@days_of_week = []
		@dau = []


		(0..7).to_a.reverse.each do |d|
			@emails << MessageLog.where("method like 'email' AND created_at < '#{(DateTime.now - d.days).in_time_zone}' AND created_at > '#{(DateTime.now - d.days - 1.days).in_time_zone}'").count
			@push_notifications << MessageLog.where("method like 'push' AND created_at < '#{(DateTime.now - d.days).in_time_zone}' AND created_at > '#{(DateTime.now - d.days - 1.days).in_time_zone}'").count
			@new_users << Fan.where("created < '#{(DateTime.now - d.days).to_f}' AND created > '#{(DateTime.now - d.days - 1.days).to_f}'").count
			@daily_trade_offers << MlbTrade.where("timestamp > #{(Time.now-d.days).to_f} AND timestamp <= #{(Time.now-(d-1).days).to_f}").count
			@daily_trade_accepts << MlbTrade.where("timestamp > #{(Time.now-d.days).to_f} AND timestamp <= #{(Time.now-(d-1).days).to_f} AND (status like 'accepted' OR status like 'mooted')").count
			@dau << LoginLog.where("time_login < '#{(DateTime.now - d.days)}' AND time_login > '#{(DateTime.now - d.days - 1.days)}'").pluck(:fan_id).uniq.count
			@days_of_week << (DateTime.now - d.days).strftime("%a")
		end
		@emails_chart_url = Gchart.line(:size => default_graph_size, title: "emails sent in last week", :data => @emails, :axis_with_labels => ['x,y'], axis_labels: [@days_of_week], :axis_range => [nil, [@emails.min, @emails.max, 500]])
		@push_notifications_chart_url = Gchart.line(:size => default_graph_size, title: "push notifications sent in last week", :data => @push_notifications, :axis_with_labels => ['x,y'], axis_labels: [@days_of_week], :axis_range => [nil, [@push_notifications.min, @push_notifications.max]])
		@news_fans_chart_url = Gchart.line(:size => default_graph_size, title: "new users in last week", :data => @new_users, :axis_with_labels => ['x,y'], axis_labels: [@days_of_week], :axis_range => [@new_users.min, @new_users.max])
		@dau_chart_url = Gchart.line(:size => default_graph_size, title: "dau this week", :data => @dau, :axis_with_labels => ['x,y'], axis_labels: [@days_of_week], :axis_range => [@dau.min, @dau.max])

		@mau = Fan.where("last_visited > '#{DateTime.now - 30.days}'").count

		@user_count = Fan.count

	end

	def huddle_last_messages_sent
		@last_push_timestamp = MessageLog.where("method like 'push' AND app like 'huddle'").last.created_at.getlocal
		@last_email_timestamp = MessageLog.where("method like 'email' AND app like 'huddle'").last.created_at.getlocal
		@last_verify_email_timestamp = MessageLog.where("method like 'email' AND kind like 'verify'").last.created_at.getlocal
		@delayed_job_count = Delayed::Job.count

	end
	def charts
		default_graph_size = '400x400'

		@measure_array = []

		url = case params[:type_of_chart]
			when "dau_last_2_weeks"
				@days_of_week = []
				(0..14).to_a.reverse.each do |d|
					@measure_array << LoginLog.where("time_login < '#{(DateTime.now - d.days)}' AND time_login > '#{(DateTime.now - d.days - 1.days)}'").pluck(:fan_id).uniq.count
					@days_of_week << (DateTime.now - d.days).strftime("%a")
				end
			Gchart.line(:size => default_graph_size, title: "dau this week", :data => @measure_array, :axis_with_labels => ['x,y'], axis_labels: [@days_of_week], :axis_range => [nil, [0, @measure_array.max, 100]])
		end
		render :json => {success: true, url: url}

	end

	def data
		case params[:data_type]
			when /activation/
				data = activation_data_provider(params[:data_type])
			else
				data = data_provider(params[:data_type])
		end
		puts data
		render :json => {success: true, data: data}							
	
	end

	def data_provider(data_type)
		puts data_type
		case data_type								

			when "total_huddle_fans"
				[HuddleFan.count]
			when "email_huddle_fans"
				 HuddleFan.joins(:fan).where("auth_type like 'bunt'").count
			when "facebook_huddle_fans"
				 HuddleFan.joins(:fan).where("auth_type like 'facebook'").count
			when "twitter_huddle_fans"
				HuddleFan.joins(:fan).where("auth_type like 'twitter'").count

			when "total_verified_huddle_fans"
				HuddleFan.joins(:fan).where("verified like 'yes'").count
			when "verified_email_huddle_fans"
				 HuddleFan.joins(:fan).where("auth_type like 'bunt' AND verified like 'yes'").count
			when "verified_facebook_huddle_fans"
				 HuddleFan.joins(:fan).where("auth_type like 'facebook' AND verified like 'yes'").count
			when "verified_twitter_huddle_fans"
				HuddleFan.joins(:fan).where("auth_type like 'twitter' AND verified like 'yes'").count

			
			when "total_huddle_trades"
				[NflTrade.count]

			when "new_huddle_fans_last_week"

				start_date=(Date.today - 7.days).to_datetime
				finish_date = Date.today.to_datetime
				new_fans_array=HuddleFan.where("huddle_profiles.created > #{(DateTime.now - 8.days).to_f}").joins(:fan).select("huddle_profiles.created, fans.auth_type")				
				(start_date..finish_date).map do |date|
					today_fans = new_fans_array.where("huddle_profiles.created > #{(date + 3.hours).to_f} && huddle_profiles.created < #{(date + 1.days + 3.hours).to_f}")
					total_fans = today_fans.count
					twitter_fans = today_fans.where("fans.auth_type like 'twitter'").count
					facebook_fans = today_fans.where("fans.auth_type like 'facebook'").count
					email_fans = today_fans.where("fans.auth_type like 'bunt'").count
					{date: date, total_fans: total_fans, twitter_fans: twitter_fans, facebook_fans: facebook_fans, email_fans: email_fans}
				end
			when "most_traded_for_players"
				player_ids = NflTrade.select("to_player_id, count(*) as to_trade_player_count").group("to_player_id").count.sort {|x,y| x[1] <=> y[1]} .last(10)			
				player_ids.map do |x,y|
					player = NflPlayer.find x
					{player_name: "#{player.first_name} #{player.last_name}", trades_offered: y}
				end
			when "huddle_registered_users_by_team"
				(NflTeam.all.sort {|b,a| a.huddle_fans.count <=> b.huddle_fans.count}).map {|team| {team_name: team.alias, fans: team.huddle_fans.count}}
			when "trade_count"
				start_date=(Date.today - 14.days).to_datetime
				finish_date = Date.today.to_datetime
				
				(start_date..finish_date).to_a.map do |date| 
					redis_entry = eval(REDIS.get("trade_efficacy_#{date.to_s}"))

					{date: date.to_s, trade_count: redis_entry[:trade_count]} 
									
				end
			when "trade_breakdown"
				start_date=(Date.today - 14.days)
				finish_date = Date.today
				
				(start_date..finish_date).to_a.map do |date| 
					redis_entry = eval(REDIS.get("daily_trade_stats_#{date}"))
					redis_entry.update({date: date.to_datetime.to_s})
				end
			when "dau_last_week"
				start_date=(Date.today - 7.days).to_datetime
				finish_date = Date.today.to_datetime
				(start_date..finish_date).to_a.map do |date|
					redis_entry = eval(REDIS.get("dau_#{date}"))
					puts redis_entry
					puts redis_entry[:unique_fan_count]
					{date: date, avg_logins: redis_entry[:avg_logins], unique_fan_count: redis_entry[:unique_fan_count]}#, avg_logins: redis_entry[:avg_logins]}
					# {date: date, fan_count: REDIS.get("dau_#{date}")}
				end
			when "traders_last_week"
				start_date=(Date.today - 7.days).to_datetime
				finish_date = Date.today.to_datetime
				(start_date..finish_date).to_a.map do |date|
					fans_who_responded = NflTrade.where("(timestamp > #{(date + 3.hours).to_f} AND timestamp < #{(date + 3.hours + 24.hours).to_f}) AND (status like 'rejected' OR status like 'accepted')").pluck("to_fan_id").uniq.count
					fans_who_offered = NflTrade.where("(timestamp > #{(date + 3.hours).to_f} AND timestamp < #{(date + 3.hours + 24.hours).to_f})").pluck("from_fan_id").uniq.count
					{date: date, traders: (fans_who_responded + fans_who_offered)}
				end

			when "huddle_zombie_fans"
				AnalyticsCache.where(kind: "zombie_fans").sort {|x,y| x.date <=> y.date} .map do |c|
					{date: c.date.to_datetime, fans_today: c.hash_data[:fans_today], 
						fans_logged_in_after_3_days: c.hash_data[:fans_logged_in_after_3_days], 
						fans_logged_in_after_7_days: c.hash_data[:fans_logged_in_after_7_days]}
				end
			
			when "dau_stats"
				AnalyticsCache.where(kind: data_type).sort {|x,y| x.date <=> y.date} .map do |c|
					{
						date: c.date.to_datetime,
						total_dau: c.hash_data[:total_dau], 
						traders_today: c.hash_data[:traders_today], 
						accumulated_fans_today: c.hash_data[:accumulated_fans_today]
					}
				end
			when "sits_and_starts"
				start_date=(Date.today - 7.days).to_datetime
				finish_date = Date.today.to_datetime
				(start_date..finish_date).to_a.map do |date|
					{date: date, shout_outs: SitStartLog.huddle.where(created: date.beginning_of_day..date.end_of_day).count}
				end
			when "average_number_of_sits_and_starts"
				start_date=(Date.today - 7.days).to_datetime
				finish_date = Date.today.to_datetime
				(start_date..finish_date).to_a.map do |date|
					sit_start_logs = SitStartLog.huddle.where(created: date.beginning_of_day..date.end_of_day)
					{date: date, avg_count: sit_start_logs.count.to_f / 
						sit_start_logs.pluck(:fan_id).uniq.count.to_f}
				end

		end


	end

	def activation_data_provider(data_type)
		AnalyticsCache.where(kind: data_type).sort {|x,y| x.date <=> y.date} .map do |c|
			{
				date: c.date.to_datetime,
				initial: c.hash_data[:initial], 
				after_3_days: c.hash_data[:after_3_days], 
				after_7_days: c.hash_data[:after_7_days]
			}
		end

	end

end



class AnalyticsCache < ActiveRecord::Base
  attr_accessible :int_data, :kind, :time, :hash_data, :date
  serialize :hash_data, Hash



  def self.cache_activation_stats(date)
		puts "beginning to cache zombie users for date: #{date.to_s}"
		puts "this is a long running process and should be placed in a separate worker queue"
		
		#all fans who registered on the given date
		total_fans =  HuddleFan.where(created: (date.to_datetime + 3.hours).to_f..(date.to_datetime + 27.hours).to_f)

		analytics_hash_collection = {overall_fans: {},
		verified_fans: {},
		trades_offered_fans: {},
		trades_offered_to_fans: {},
		shoutout_fans: {}}



		#total users who meet each criterion
		analytics_hash_collection[:overall_fans][:initial] = total_fans.count 

		#fans with a verified account...at the moment includes FB and twitter users
		analytics_hash_collection[:verified_fans][:initial] = total_fans.joins(:fan).where("fans.verified like 'yes'").count

		#users who have offered at least one trade ever
		analytics_hash_collection[:trades_offered_fans][:initial] = total_fans.to_a.count {|f| f.trades_offered.exists? }
		
		#users who have received at least one trade offer ever
		analytics_hash_collection[:trades_offered_to_fans][:initial] = total_fans.to_a.count {|f| f.trades_offered_toexists? }
		
		#fans who have ever set their shoutout
		analytics_hash_collection[:shoutout_fans][:initial] = total_fans.where("shout_out_ts is not null").count
		
		#more initalization
		analytics_hash_collection.each do |k,v|
			analytics_hash_collection[k].update({after_3_days: 0, after_7_days: 0})
		end

		#lambda to DRY up the updating of the different hash pieces
		#after_x_days is the hash_key for each of the individual hashes
		#e.g. :after_3_days or :after_7_days
		
		#fan has to be passed if this is going to be outside the loop
		#could maybe be inside though?  migth get cluttered
		increment_analytics_hash_pieces = lambda do |fan, after_x_days|
			analytics_hash_collection[:overall_fans][after_x_days] += 1
		
			if fan.verified
				analytics_hash_collection[:verified_fans][after_x_days] += 1
			end

			if fan.trades_offered.exists?
				analytics_hash_collection[:trades_offered_fans][after_x_days] += 1
			end
			if fan.trades_offered_to.exists?
				analytics_hash_collection[:trades_offered_to_fans][after_x_days] += 1
			end

			if fan.shout_out_ts
				analytics_hash_collection[:shoutout_fans][after_x_days] += 1
			end

		end
		#check if there's going to be enough data to fill out the chart
		#not sure if i should keep this or what
		if (date + 3.days) < Date.today

			total_fans.each do |fan|

				if fan.logged_in_after_x_days(3)
					increment_analytics_hash_pieces.call(fan, :after_3_days)
		
					#check if there's going to be enough data to fill out the chart
					#not sure if i should keep this or what
					if (date + 7.days) < Date.today
						if fan.logged_in_after_x_days(7)
							increment_analytics_hash_pieces.call(fan, :after_7_days)
						end
					end
				end
			end
		end
		puts "here"
		analytics_hash_collection.each do |k,v|
			cache = AnalyticsCache.find_or_initialize_by_kind_and_date("activation_#{k.to_s}", date + 1.days)
			cache.hash_data = v
			cache.save
		end
	end

	def self.cache_dau_stats(date)
		today_range_datetime = (date.to_datetime.beginning_of_day + 3.hours)..(date.to_datetime.beginning_of_day + 27.hours)
		today_range_unix = (date.to_datetime.beginning_of_day + 3.hours).to_f..(date.to_datetime.beginning_of_day + 27.hours).to_f

		total_dau = LoginLog.where(time_login: (date.to_datetime.beginning_of_day + 3.hours)..(date.to_datetime.beginning_of_day + 27.hours)).pluck(:fan_id).uniq.count
		#why does this only work with 2 queries like that?  what's the deal there?
		traders_today = (NflTrade.where(timestamp: today_range_unix).pluck(:from_fan_id) | NflTrade.where(timestamp: today_range_unix).pluck(:to_fan_id)).uniq.count
		accumulated_fans_today = HuddleFan.where("created < #{(date.to_datetime.beginning_of_day + 27.hours).to_f}").count

		cache = AnalyticsCache.find_or_initialize_by_kind_and_date("dau_stats", date + 1.days)
		cache.hash_data = {total_dau: total_dau, traders_today: traders_today, accumulated_fans_today: accumulated_fans_today}
		cache.save

	end
end

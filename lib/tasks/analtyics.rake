desc "cache trade stats in redis"
task :trade_stats_cache => :environment do 
	start_date=(Date.today - 15.days)
	finish_date = Date.today
	(start_date..finish_date).to_a.reverse.each do |date|
		trade_array = NflTrade.where("timestamp > #{(date.to_datetime + 3.hours).to_f} AND timestamp < #{(date.to_datetime + 1.days + 3.hours).to_f}").select("status").to_a
		trade_status_counts = {}
		%w(accepted rejected mooted cancelled).each do |status|
			trade_status_counts.update({status.to_sym=>trade_array.count {|x| x.status == status}})
		end
		trade_efficacy = ((trade_status_counts[:accepted] +  trade_status_counts[:rejected]).to_f / (trade_array.count.to_f - (trade_status_counts[:mooted] +  trade_status_counts[:cancelled]).to_f))
		final_hash = {trade_count: trade_array.count, trade_efficacy: trade_efficacy * 100, }.update(trade_status_counts)
		REDIS.set("daily_trade_stats_#{date.to_s}", final_hash)
	end
end



desc "zombie fans cache"
task :update_30_days_of_retention_data => :environment do
	start_date = DateTime.strptime(HuddleFan.first.created.to_s, "%s").to_date
	finish_date = Date.today
	(start_date..finish_date).to_a.each do |date|
		AnalyticsCache.cache_activation_stats date
	end
end

desc "cache dau stats"
task :cache_dau_stats => :environment do
	start_date = DateTime.strptime(HuddleFan.first.created.to_s, "%s").to_date
	finish_date = Date.today
	(start_date..finish_date).to_a.each do |date|
		AnalyticsCache.cache_dau_stats date
	end
end






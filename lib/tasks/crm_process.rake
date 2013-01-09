
require "aws-sdk"
require "httparty"
require "open-uri"

require "sqs_monitoring"
include SqsMonitoring

desc "monitor bunt sqs"
task :bunt_sqs => :environment do 
	monitor_sqs "bunt"
end

desc "monitor huddle sqs"
task :huddle_sqs => :environment do 
	monitor_sqs "huddle"
end


desc "update email blacklist"
task :update_email_blacklist => :environment do
	["bounces", "invalidemails"].each do |action|
		response = HTTParty.get("https://sendgrid.com/api/#{action}.get.json?api_user=#{ENV['SENDGRID_USERNAME']}&api_key=#{ENV['SENDGRID_PASSWORD']}")
		json = JSON.parse response
		json.each do |entry| 
			BlackListedEmail.create(address: entry["email"], reason: entry["reason"], method: "email")
		end
	end
	Pony.mail(to: ["michael.magner@gmail.com", "xxxxxxxxx"], html_body: "Time: #{Time.now.to_s}\nBlacklist count: #{BlackListedEmail.count.to_s}" , subject: "email blaclist succesfully updated", from: "magz_testing")
	
	

end

desc "test"
task :test => :environment do
	puts "hi magz"
end

desc "clear delayed jobs"
task :delete_jobs => :environment do
	puts 'deleting delayed jobs'
	Delay::Job.count
	puts "counted"
	Delay::Job.all.each {|j| j.delete}
end

desc "average fan points per team"
task :average_fan_points_per_team => :environment do

end

desc "module test"
task :test_module => :environment do 
	first_method


end

desc "mem_test"
task :mem_test => :environment do 
	'RAM USAGE: ' + `pmap #{Process.pid} | tail -1`[10,40].strip
end




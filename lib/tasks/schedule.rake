desc "This task is called by the Heroku scheduler add-on"
task :update_email_blacklist_full => :environment do
    puts "Updating email blacklist..."
    uri = URI.parse("https://sendgrid.com/api/invalidemails.get.json?api_user=" + ENV['SENDGRID_USERNAME'] + "&api_key=" + ENV['SENDGRID_PASSWORD'])
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Get.new(uri.request_uri)
	
	response = http.request(request)

	puts response.body
	puts response.code
	puts response.code =~ /3\d\d/
	if response.code =~ /2\d\d/
		JSON.parse(response.body).each do |entry|
			unless InvalidEmail.find_by_address entry["email"]
				InvalidEmail.create(address: entry["email"], reason: entry["reason"])
			end
		end
	end

end




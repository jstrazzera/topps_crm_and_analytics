class MainController < ApplicationController
	require "browser"
	include MainControllerHelpers

	before_filter :check_login, only: "push_test"

	def redirector

	end

	def manual_email_verification_send
		fan = Fan.find_by_fan_name params[:fan_name]
		if fan
			fan.send_verify_email
			render text: "fan #{fan.fan_name} send a verify email"
		else
			render text: "fan not found"
		end

	end

	def welcome

		@focus_avatar = get_focus_avatar_hash(params)

		@browser = Browser.new(ua: request.env['HTTP_USER_AGENT'], :accept_language => "en-us")

		#test this

		@bleacher_fans_and_text = get_bleacher_fans(@focus_avatar[:avatar])
		

		

		if (@browser.mobile? && !browser.ipad? && !browser.android?)  
			if (request.env['HTTP_USER_AGENT'].to_s.downcase =~ /twitter/ || request.env['HTTP_USER_AGENT'].to_s.downcase =~ /fb/)
				@disable_app_store_link = false
			else
				@disable_app_store_link = true 
			end
			render "mobile_welcome"
		else 
			render "welcome"
		end
	end
	
	def tos
	
	end

	def privacy_policy
	
	end

	def send_sms
		return_message = ""

		puts "phone " + params[:phone_number]
		puts params[:phone_number] != ""
		if params[:phone_number] && params[:phone_number] != ""
			puts "ok were in here"
			@target_number = params["phone_number"]
			puts @target_number
		  	unless @target_number[0] == "1"
		  		@target_number = "1" + @target_number
		  	end

		  	sms = Moonshado::Sms.new(@target_number, "Topps Bunt in the App Store! http://bit.ly/LRNCtH")
		  	sms.deliver_sms
		  	return_message += "sms message sent \n"
		end

		if params[:email_address] != "" && params[:mailing_list] == true
			Pony.mail(:to => 'ttate@topps.com', :from => 'email_form@bunt.topps.com', 
				:subject => "if you're seeing this, the email form is working properly", :body => params[:email_address])

			return_message += "email message sent to Trip"
		else
			Pony.mail(:to => params[:email_address], :from => 'support@bunt.topps.com', 
				:subject => "Topps Bunt App Store Link", :body => "Topps Bunt in the App Store! http://bit.ly/LRNCtH")

		end

		unless return_message == ""
			puts return_message
			render json: return_message
		else
			render json: "failure"
		end
		  	
	end

	def ipad_welcome
		@focus_avatar = get_focus_avatar_hash(params)

		@browser = Browser.new(ua: request.env['HTTP_USER_AGENT'], :accept_language => "en-us")

		#test this

		@bleacher_fans_and_text = get_bleacher_fans(@focus_avatar[:avatar])
		
	end

	def mobile_welcome
		@focus_avatar = get_focus_avatar_hash(params)

		@browser = Browser.new(ua: request.env['HTTP_USER_AGENT'], :accept_language => "en-us")



	end

	def about

	end

	def push_test
		fan = Fan.find_by_fan_name params[:fan_name].upcase
		unless params[:app] == "bunt"
			fan = fan.huddle_fan
		end
		if fan
			%w(joined offer accept player_news).each {|x| fan.push_test(x)}
			render text: "success"
		else
			render text: "user #{params[:fan_name].upcase} not found"
		end
	end
end

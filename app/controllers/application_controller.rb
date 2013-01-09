class ApplicationController < ActionController::Base
  protect_from_forgery
  require "browser"
  require "HashHasKeys"

  before_filter :get_browser_agent

  def check_login
    unless current_user then redirect_to :login end
  end


  def get_browser_agent
	   @browser = Browser.new(ua: request.env['HTTP_USER_AGENT'], :accept_language => "en-us")
  end

	private

	def current_user
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	helper_method :current_user

end

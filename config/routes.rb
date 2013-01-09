BuntWebApp::Application.routes.draw do
  
  resources :nfl_games

  resources :message_logs

  resources :messages

  resources :black_listed_emails

  resources :invalid_emails

  resources :templates

  resources :teams  

  match "main/manual_email_verification_send/:fan_name" => "main#manual_email_verification_send"
  match "push_test/:fan_name" => "main#push_test"
  match "analytics/data/:data_type" => "analytics#data"
  match "/analytics/:action", :controller => 'analytics' 
  
  match "login" => "sessions#new", as: :login
  match "logout" => "sessions#destroy", as: :logout
  
  resources :sessions
  
  match "server_time" => "crm#server_time"

  match "help" => redirect("http://toppsbunt.zendesk.com"), :as => :help
  match "blog" => redirect("http://toppsbunt.tumblr.com"), :as => :blog
  match "about" => "main#about", :as => :about 
  match "terms" => "main#tos", :as => :terms
  match "privacy" => "main#privacy_policy", :as => :privacy

  match "add_to_crm_queue" => "crm#create_queue_entry"

  match "send_sms" => "main#send_sms", :as => :send_sms
  match "mail_list_signup" => "mailing_list_emails#create", via: :post, as: "email_list_signup"


  match "mobile" => "main#mobile_welcome"
  match "ipad" => "main#ipad_welcome"
  match "iphone" => "main#mobile_welcome"
  match "forgot_password" => redirect("http://api.toppsbunt.com/bunt/default/user/retrieve_password")

  root :to => 'main#welcome'

end

Pony.options = {
  :via => :smtp,
  :via_options => {
    :address => 'smtp.sendgrid.net',
    :port => '587',
    :domain => 'heroku.com',
    :user_name => "xxxxxxxxxxxxx",
    :password => "xxxxxxx",
    :authentication => :plain,
    :enable_starttls_auto => true
  }
}

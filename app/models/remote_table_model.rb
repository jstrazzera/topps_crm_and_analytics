class RemoteTableModel < ActiveRecord::Base
	self.abstract_class = true
	
	establish_connection(
      :adapter  => 'mysql2',
      :host     => "bunt.c76vwj0m73zb.us-east-1.rds.amazonaws.com",
      :username => "magz",
      :password => "xxxxxxx",
      :timeout  => 10000,

      :database => "bunt",
      :port     => 3306
    )


end

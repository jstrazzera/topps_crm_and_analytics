class MaBanditRecord < ActiveRecord::Base
  attr_accessible :fan_id, :group, :ma_bandit_id, :success
  belongs_to :ma_bandit


  def update_success_or_fail
  	puts "updating record #{id}"
    case self.ma_bandit.name
  		when "welcome_drip_push_test_1"
  			puts "here here"
        if self.created_at < (DateTime.now -3.days)
  				puts "in here"
          success_date_range = (created_at + 3.days)..(created_at + 7.days)
  				if LoginLog.where(fan_id: fan_id, time_login: success_date_range).exists?
  					self.success = true
  				else
  					self.success = false
  				end
  			  puts "success state changed to #{self.success.to_s}"
          save!
        end

  		when "test"
  			puts "ok we're in test"
  			self.success = true
  			save!
  			puts "Saved"
  			if success == nil
	  			r = rand(2)
	  			puts r
	  				if r == 0
	  					self.success = true
	  				else
	  					self.success = false
	  				end
  			end
  			save!
  	end

  end

end

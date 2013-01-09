class BlackListedEmail < ActiveRecord::Base
  attr_accessible :address, :method, :reason
  validates_uniqueness_of :address, scope: :reason
  def self.check_to_send_email(type, kind, address)
	BlacklistedEmail.where("type like '#{type} AND address like '#{address}'")	== nil
  end



end



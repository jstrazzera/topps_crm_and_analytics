class MailingListEmail < ActiveRecord::Base
  attr_accessible :address, :team_id
  belongs_to :team
  validates :address, :presence => true


   
end

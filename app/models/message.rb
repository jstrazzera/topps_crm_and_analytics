class Message < ActiveRecord::Base
  attr_accessible :attempted, :batch_id, :message, :success, :type
end

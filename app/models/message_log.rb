class MessageLog < ActiveRecord::Base
  attr_accessible :fan_id, :kind, :method, :success, :blurb_id, :data, :app, :sent, :version
end

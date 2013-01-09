class AbTestCache < ActiveRecord::Base
  attr_accessible :app, :fan_id, :group, :success, :test_name
end

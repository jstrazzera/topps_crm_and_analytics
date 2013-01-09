class Template < ActiveRecord::Base
  attr_accessible :body, :email_type, :subject, :target, :app, :archived, :version, :deep_link_key, :deep_link_value
  default_scope where(archived: false)


end

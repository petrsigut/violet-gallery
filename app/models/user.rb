class User < ActiveRecord::Base
  
  # for available options see documentation in: Authlogic::ActsAsAuthentic
  acts_as_authentic do |c|
    c.validate_email_field = false
  end

end

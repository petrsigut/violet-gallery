desc "Add default user do violet admin - violet:violet"
task(:default_user => :environment) do
  u = User.create :login => "violet", :password => "violet", :password_confirmation => "violet"
  u.save
end

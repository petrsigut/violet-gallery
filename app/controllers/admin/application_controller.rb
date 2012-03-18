# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class Admin::ApplicationController < ApplicationController
  helper :all # include all helpers, all the time
  before_filter :set_locale, :require_user 
  layout "admin"
end

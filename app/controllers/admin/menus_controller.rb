class Admin::MenusController < Admin::ApplicationController

  def index
    @user = User.find(:first)
  end
  
end

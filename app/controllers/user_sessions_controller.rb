class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new]
  #before_filter :require_no_user, :only => [:new, :create]
  #before_filter :require_user, :only => :destroy
  layout "default", :only => "new"
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = t(:login_successful)
      #redirect_back_or_default account_url
      #redirect_back_or_default account_url
      redirect_to admin_path
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    flash[:notice] = t(:logout_successful)
    redirect_back_or_default new_user_session_url
  end
end

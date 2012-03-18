# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  before_filter :set_locale, :set_mailer_url_options, :get_virtual_sections
  before_filter :counter


  def set_mailer_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
    #request.host  would return the host without the port number (quite obvious I guess)
  end

  # used in guestbook and comment model to prohibit these words in comments  
  #def define_spam_words
  #  Array['link=http', 'viagra', 'amoxil', 'prednisolone', 'meclizine', 'sinequan', 'alendronic', 'cavumox', 'cialis', 'health insurance', 'carisoprodol']
  #end




  # Get locale code from request subdomain (like http://it.application.local:3000) # You have to put something like: # 127.0.0.1 gr.application.local # in your /etc/hosts file to try this out locally
  def set_locale
    # if it is sigut.net
    if (request.subdomains(-1).size == 2 or request.subdomains.first == "beta" or request.subdomains.first == "alfa" or request.subdomains.first == "www" or request.subdomains.first == "demo") 
      @mydomain = request.host_with_port
      I18n.locale = I18n.default_locale
    else # en.sigut.net
      @mydomain = request.subdomains(-1)[1..-1].join('.')+":"+request.port.to_s
      I18n.locale = request.subdomains.first
    end
    if @mydomain[0..2] == "www"
      @mydomain_without_www = @mydomain[4..-1].to_s
    else
      @mydomain_without_www = @mydomain.to_s
    end
  end


 # helper_method :sections_menu
  helper_method :amount_in_cart

  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user
  


#--------------------------------------------------
#   def all_sections
#     @sections = Section.all(:order => "position",
#                             :conditions => 'sections.builtin != 1')
#     @sections_builtin = Section.all(:order => "position",
#                             :conditions => 'sections.builtin = 1 and id != 17')
# 
#   end
#-------------------------------------------------- 

  def get_virtual_sections
    section = Section.find_by_virtual_name(params[:controller]+"-"+params[:action])
    unless section.nil?
      @section = section
    end

    @textbox_news = Textbox.find_by_hardcoded_name('news');
    @textbox_like_my_photos = Textbox.find_by_hardcoded_name('like_my_photos');
    @textbox_banner_top = Textbox.find_by_hardcoded_name('banner_top');
  end



  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  #
  private

#--------------------------------------------------
#   def expire_index_page
#     expire_page :controller => "sections", :action => "all_photos"
#     expire_page '/index'
#     FileUtils.rm_rf "#{RAILS_ROOT}/public/all"
#   end
#-------------------------------------------------- 


  def find_cart
    if session[:cart_id].blank?
      @cart = Cart.new
      @cart.save
      session[:cart_id] = @cart.id
    else  # kdyz uz kosik mame tak jen z sezny vytahneme jeho id
      @cart = Cart.find_by_id(session[:cart_id])
      if @cart.nil?
        @cart = Cart.new
        @cart.save
        session[:cart_id] = @cart.id
      end
    end
  end


  # predelat do modelu counter.rb a counter_visitor.rb
  def counter
    browser = request.env['HTTP_USER_AGENT']
    ip = request.env['REMOTE_ADDR']

    @counter = Counter.find(:first)
    if @counter.nil? then @counter = Counter.new end

    # delete old entries of visitors
    CounterVisitor.connection.execute("DELETE FROM `counter_visitors` WHERE created_at + INTERVAL 6 HOUR < NOW()")
    #@old_visitors = CounterVisitor.find(:all, :conditions => ["created_at < ?", DateTime.now+6.hours])
   
    maybe_our_visitor = CounterVisitor.find_by_ip(ip)
    # if IP is not in db - we iterate counter and log visitor
    if maybe_our_visitor.nil?
      visitor = CounterVisitor.new
      visitor.browser = browser
      visitor.ip = ip
      visitor.save
      @counter.count += 1
      @counter.save
    end
    @counter
  end



  
  def amount_in_cart
    @cart = Cart.find_by_id(session[:cart_id])
    if @cart
      @ordered_photos = @cart.ordered_photos.find(:all)
      amount_in_cart = @ordered_photos.count
    else
      amount_in_cart = 0
    end
  end

 def current_user_session
   return @current_user_session if defined?(@current_user_session)
   @current_user_session = UserSession.find
 end

 def current_user
   return @current_user if defined?(@current_user)
   @current_user = current_user_session && current_user_session.user
 end

 def require_user
      unless current_user
        store_location
        flash[:notice] = t(:logged_in_require)
        redirect_to new_user_session_url
        return false
      end
    end
 
    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end


end

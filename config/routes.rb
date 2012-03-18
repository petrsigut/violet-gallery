ActionController::Routing::Routes.draw do |map|
  map.root :controller => "sections", :action => "show", :id => "3"
  
  map.connect '/contact', :controller => 'info', :action => 'contact'
  map.connect '/sections/:id/page/:page', :controller => 'sections', :action => 'show'
  map.connect '/page/:page', :controller => 'sections', :action => 'show'
  map.connect 'comments/page/:page', :controller => 'comments', :action => 'index'
  #map.all '/all', :controller => 'sections', :action => 'show', :id => "1"
  #map.connect '/all/page/:page', :controller => 'sections', :action => 'all_photos'
  map.connect '/guestbooks/page/:page', :controller => 'guestbooks', :action => 'index'
  map.resources :events
  map.resources :guestbooks
  map.resources :carts
  map.resources :ordered_photos
  map.resources :comments
  map.resources :menus
  map.resources :emailer


#  map.approve 'admin/comments/approve', :controller => 'admin/comments', :action => 'approve'
#  map.approve_comment 'admin/comments/approve_comment', :controller => 'admin/comments', :action => 'approve_comment'
  map.namespace(:admin) do |admin|
    admin.resources :photos
    admin.resources :sections, :collection => { :sort => :post }, :member => {:publish => :get, :unpublish => :get}
    admin.resources :menus
    admin.resources :carts, :collection => {:in_printer => :get, :received_money => :get}
    admin.resources :comments, :member => {:approve => :get}, :collection => {:approve_index => :get}
    admin.resources :guestbooks
    admin.resources :events
    admin.resources :textboxes
  end
  
#    map.resources :comments, :member => {:approve_comment => :get}
  
#  map.resources :sections, :collection => { :sort => :post }

  #map.all '/all_comments', :controller => 'comments', :action => 'all'

  map.connect 'photos/feed.:format', :controller => 'photos', :action => 'feed'
  

  map.resources :sections do |section|
    section.resources :photos
  end 

  map.resources :photos do |photo|
    photo.resources :comments
  end 

  map.resources :carts do |cart|
    cart.resources :ordered_photos
  end 


  # authlogic
  map.resource :user_session
  map.root :controller => "user_sessions", :action => "new" # optional, this just sets the root route
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'  
  map.admin 'admin', :controller => 'admin/menus', :action => 'index'
  map.resource :account, :controller => "users"
  map.resources :users

  # See how all your routes lay out with "rake routes"
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end


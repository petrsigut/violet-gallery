class PhotosController < ApplicationController
  
  layout "gallery_photo", :except => "feed"

  # http://toddsiegel.com/2008/02/29/generating-rss-in-rails/
  def feed
    @photos = Photo.find(:all, :include => :section, :limit => 20, :order => "created_at DESC")
    @title = Setting.get_setting("gallery_name")+" | "+t(:rss_new_photos)
    @description = t(:rss_new_photos)+" "+Setting.get_setting("gallery_name")
    @locale =  t(:rss_locale)
    @author = @title
    @site = "http://"+request.host_with_port
  end

  def show
    @site = request.url
    @back_section = params[:query] || params[:section_id]
    session[:from_destroy] = "false"

    @photo = Photo.find(params[:id], :include => :section, :order => "created_at DESC")
    @comments = @photo.comments.approved
    @comment = Comment.new

    ip = request.remote_ip
    @photo.increase_number_of_views(ip)

    @title = @photo.title+" | "+Setting.get_setting("gallery_name")


    respond_to do |format|
      format.html 
      format.js
    end
  end

   def next
    @site = request.url
    @back_section = params[:query] || params[:section_id]
    session[:from_destroy] = "false"

    @photo = Photo.find(params[:id], :include => :section, :order => "created_at DESC")
    @comments = @photo.comments.approved
    @comment = Comment.new

    ip = request.remote_ip
    @photo.increase_number_of_views(ip)

    @title = @photo.title+" | "+Setting.get_setting("gallery_name")

    respond_to do |format|
      format.js
    end
  end

  

end


class SectionsController < ApplicationController
  layout 'gallery'
#  caches_page :all_photos
#  handles_sorting_of_nested_set

#--------------------------------------------------
#   def all_photos
#     newest_comments
#     @new_photos = Photo.find(:all, :include => :section,
#                              :conditions =>['sections.builtin != 1'],
#                              :order => 'photos.created_at DESC')
#     @photos = @new_photos.paginate :page => params[:page],
#       :per_page => Setting.get_setting("photos_per_page")
#   end
#-------------------------------------------------- 
#--------------------------------------------------
# 
#   def most_viewed
#     newest_comments
#     @new_photos = Photo.find(:all, :include => :section,
#                              :conditions =>['sections.builtin != 1'],
#                              :order => 'photos.view DESC')
#     @photos = @new_photos.paginate :page => params[:page],
#       :per_page => Setting.get_setting("photos_per_page")
# 
#     render :action => :all_photos
#   end
#-------------------------------------------------- 


  def show
    newest_comments
    calendar_set

    @section = Section.find(params[:id])

    if (@section.virtual == false)
      @photos = @section.photos.paginate :page => params[:page],
                  :order => "created_at #{@section.order}",
                  :conditions => ['photos.publish_at <= NOW()'],
                  :per_page => Setting.get_setting("photos_per_page")

    elsif (@section.virtual_name == "sections-all_photos")
      @photos = Photo.paginate :include => :section,
            :conditions =>['sections.builtin != 1 and photos.publish_at <= NOW()'],
            :order => 'photos.created_at DESC', :page => params[:page],
            :per_page => Setting.get_setting("photos_per_page")
      render :action => "all_photos"

    elsif (@section.virtual_name == "sections-most_viewed")
      @photos = Photo.paginate :include => :section,
            :conditions =>['sections.builtin != 1 and photos.publish_at <= NOW()'],
            :order => 'photos.view DESC', :page => params[:page],
            :per_page => Setting.get_setting("photos_per_page")
    end



  end





  def calendar_nav
    calendar_set
    respond_to { |format| format.js }
  end

  private
  def newest_comments
    @comments_newest = Comment.approved_newest
  end

  def calendar_set 
    # set actual month unless user want to see different month
    time_from_query = Time.now
    unless (params[:query]).nil?
      time_from_query = params[:query].to_date
    end
    @time_from_query = time_from_query
    @month_to_show = time_from_query.month
    @year_to_show = time_from_query.year
    @dates = Event.find(:all, :select => "date").map(&:date)
    @dates_future = Event.find(:all, :select => "date",
                    :conditions => ["date >= ?", Date.today]).map{|p| I18n.localize(p.date)}


  end


end

class Admin::PhotosController < Admin::ApplicationController

  before_filter :publish_at_array, :only => [:new, :edit, :create]

  def index
    @sections = Section.find(:all, :conditions => {:virtual => false, :folder => false})
    @section_id = params["section_id"]
    
    if (@section_id.nil? || @section_id == "")
      @photos = Photo.paginate(:include => :section,
                             :order => 'photos.created_at DESC',
                             :page => params[:page])

    else
      @photos = Photo.paginate(:include => :section,
                             :order => 'photos.created_at DESC',
                             :conditions => ['section_id = ?', @section_id.to_i],
                             :page => params[:page])
   end

    respond_to do |format|
      format.js
      format.html
    end
  end

 
  # GET /photos/new
  # GET /photos/new.xml
  def new
    @photo = Photo.new
    @sections = Section.find(:all, :conditions => {:virtual => false, :folder => false})
    @authors = Author.all
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  def show
    @photo = Photo.find(params[:id], :include => :section)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end



  def hide
    respond_to { |format| format.js }
  end

  # GET /photos/1/edit
  def edit
    @authors = Author.all
    session[:back_to_edit_page] = params[:page]
    session[:back_to_edit_section] = params[:section]
    @publish_at.insert(0,[t(:do_not_change), "do_not_change"])
    @photo = Photo.find(params[:id])
    @sections = Section.find(:all, :conditions => {:virtual => false, :folder => false})
  end

  # POST /photos
  # POST /photos.xml
  def create
    #expire_index_page

    @sections = Section.find(:all)
    
    error_in_process = false
    params[:photo][:image_file].each_with_index do |image, i|
      @photo = Photo.new(params[:photo])
      @photo.image_file = image
      @photo.seconds_to_add = i
      unless @photo.save
        error_in_process = true
      end
    end
    if error_in_process == false
      flash[:notice] = t(:photo_succ_created)
      redirect_to admin_photos_path
    else
      render :action => "new"
    end

  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    #expire_index_page
    @photo = Photo.find(params[:id])
    if (params[:photo][:publish_at] == "do_not_change")
      params[:photo][:publish_at] = @photo.publish_at
    end
    # needs to be here, do not works after update_attributes
    @photo.seconds_to_add = 0
    
  
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        # change of photo - we need to delete old thumbnail and photo and create
        # new
        unless params[:photo][:image_file].nil?
          params[:photo][:image_file].each do |image|
            @photo.image_file = image
            @photo.write_file
          end
        end
        #params["photo"].delete("image_file")

        flash[:notice] = t(:photo_succ_updated)
        format.html { redirect_to([:admin, @photo]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    #expire_index_page

    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(admin_photos_path) }
      format.xml  { head :ok }
    end
  end

  private 

  def publish_at_array

  @publish_at = [
      [t(:yes_publish), Time.now.to_s(:db)],
      [t(:no_publish), nil],
      [t(:tomorrow), (Time.now+1.days).to_s(:db)],
      [I18n.localize(Time.now+2.days, :format => :nice), (Time.now+2.days).to_s(:db)],
      [I18n.localize(Time.now+3.days, :format => :nice), (Time.now+3.days).to_s(:db)],
      [I18n.localize(Time.now+4.days, :format => :nice), (Time.now+4.days).to_s(:db)],
      [I18n.localize(Time.now+5.days, :format => :nice), (Time.now+5.days).to_s(:db)],
      [I18n.localize(Time.now+6.days, :format => :nice), (Time.now+6.days).to_s(:db)],
      [I18n.localize(Time.now+7.days, :format => :nice), (Time.now+7.days).to_s(:db)]]
  end

  
end

class NewestsController < SectionsController
  
  def index
    @sections = Section.find(:all)
    
    @section = Section.new
    @section.title = "Nejnovější"

    @new_photos = Photo.find(:all)
    @photos = @new_photos.paginate :page => params[:page], :order => 'created_at ASC',
      :per_page => 5
  end

end

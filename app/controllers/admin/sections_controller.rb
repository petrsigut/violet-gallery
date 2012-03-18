class Admin::SectionsController < Admin::ApplicationController

  def index
    @sections = Section.all(:order => "position", :conditions => {:virtual => false})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sections }
    end
  end

   def move
     new_position = position_of(:moved_element_id).in_tree(:tree_element)
   end


  # GET /sections/new
  # GET /sections/new.xml
  def new
    @section = Section.new
    @sections = Section.all
    @side_section_id = Section.find_by_hardcoded('side_menu').id

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def unpublish
    sections_superiors(params[:id])
    @photos = @section.photos

    @photos.each do |p|
      p.publish_at = nil
      p.save
    end
    redirect_to edit_admin_section_path(@section)
    @unpublished_photos = @photos.count
  end

  def publish
    sections_superiors(params[:id])
    @unpublished_photos = Photo.unpublished(@section.id)

    @unpublished_photos.each do |p|
      p.publish_at = Time.now
      p.save
    end
    redirect_to edit_admin_section_path(@section)
    @unpublished_photos = 0
  end

  # GET /sections/1/edit
  def edit
    sections_superiors(params[:id])
    @unpublished_photos = Photo.unpublished(@section.id).count
  end

  # POST /sections
  # POST /sections.xml
  def create
    @section = Section.new(params[:section])
    @sections = Section.all

    respond_to do |format|
      if @section.save
        flash[:notice] = 'Sekce byla úspěšně vytvořena.'
        format.html { redirect_to(admin_sections_url) }
        format.xml  { render :xml => @section, :status => :created, :location => @section }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sections/1
  # PUT /sections/1.xml
  def update
    @section = Section.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        flash[:notice] = 'Sekce byla úspěšně upravena.'
        format.html { redirect_to(admin_sections_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @section = Section.find(params[:id])

    if (@section.photos.count == 0)
      @section.destroy
      flash[:notice] = 'Sekce úspěšně smazána.'
      redirect_to(admin_sections_url)
    else
      flash[:notice] = 'Nelze smazat sekce ve které jsou fotografie.'
      redirect_to(admin_sections_url)
    end
  end

  def sort
    #logger.fatal "sort jak cyp"
    set_parent_and_position(nil, params['sections'])
#--------------------------------------------------
#     params[:sections].each_with_index do |id, index|
#       Section.update_all(['position=?', index+1], ['id=?', id])
#     end
#-------------------------------------------------- 
    render :nothing => true
  end
  def set_parent_and_position(parent, sortable)
    sortable.each do |pos, hash|
      id = hash.delete("id")
      Section.update(id, {:position => pos.to_i + 1, :parent_id => parent})
      set_parent_and_position(id, hash)
    end
  end

  private

  def sections_superiors(section_id)
    @section = Section.find(section_id)
    @sections_superiors = Section.find(:all, :conditions => ['id != ?', @section.id])
  end


end

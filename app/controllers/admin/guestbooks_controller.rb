class Admin::GuestbooksController < Admin::ApplicationController

  def index
    @guestbooks = Guestbook.paginate :order => 'created_at DESC',
    :page => params[:page], :per_page => 52

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @guestbooks }
    end
  end

  # GET /guestbooks/1/edit
  def edit
    @guestbook = Guestbook.find(params[:id])
  end
  # PUT /guestbooks/1
  # PUT /guestbooks/1.xml
  def update
    #expire_page :controller => 'guestbook', :action => 'index'
    @guestbook = Guestbook.find(params[:id])

    respond_to do |format|
      if @guestbook.update_attributes(params[:guestbook])
        flash[:notice] = 'Guestbook was successfully updated.'
        format.html { redirect_to admin_guestbooks_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @guestbook.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /guestbooks/1
  # DELETE /guestbooks/1.xml
  def destroy
    #expire_page :controller => 'guestbook', :action => 'index'
    @guestbook = Guestbook.find(params[:id])
    @guestbook.destroy

    respond_to do |format|
      format.html { redirect_to(admin_guestbooks_url) }
      format.xml  { head :ok }
    end
  end


end

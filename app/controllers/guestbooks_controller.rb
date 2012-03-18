class GuestbooksController < ApplicationController
  layout "gallery"
#  caches_page :index

  def index
    # for _new
    @guestbook = Guestbook.new

    @guestbooks = Guestbook.paginate :order => 'created_at DESC', :page => params[:page], :per_page => 52

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /guestbooks/new
  def new
    @guestbook = Guestbook.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @guestbook }
    end
  end


  # POST /guestbooks
  # POST /guestbooks.xml
  def create
    #expire_page :action => 'index'

    @guestbook = Guestbook.new(params[:guestbook])
    spam = params[:guestbook_spam]
    @guestbook.ip = request.remote_ip

    @guestbooks = Guestbook.find(:all, :order => 'created_at DESC')
    @guestbooks = @guestbooks.paginate :page => params[:page],
      :per_page => 52



    if (spam != "1")
      flash[:notice] = t(:spam_no_ajax)
      render 'index'
    else
      respond_to do |format|
        if @guestbook.save
          format.html { redirect_to(guestbooks_path) }
          format.js
        else
          format.html { render 'index' }
        end
      end
    end

    flash.keep(:guestbook_id)
  end

end

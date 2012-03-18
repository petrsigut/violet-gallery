class CommentsController < ApplicationController
  layout "gallery"

  def index
    @comments = Comment.approved
    @comments = @comments.paginate :page => params[:page],
      :per_page => 24
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

#--------------------------------------------------
#   # GET /comments/1/edit
#   def edit
#     @comment = Comment.find(params[:id])
#   end
# 
#-------------------------------------------------- 
  # POST /comments
  # POST /comments.xml
  def create
#    expire_index_page
   
    find_photo(params[:photo_id])
    @comments = @photo.comments.approved

    spam = params[:comment_spam]
    @comment = @photo.comments.build(params[:comment])
    @comment.set_approval

    if (spam != "1")
      flash.now[:notice] = t(:spam_no_ajax)
      render 'photos/show'
    else
      if @comment.save
          if (@comment.approve == true and params[:format] == "html")
            flash[:notice] = t(:will_show_after_approval)
            redirect_to(photo_path(@photo))
          end
        respond_to do |format|
          format.js
        end
      else
        render 'photos/show'
      end
    end

    # tady musim osetrit ulozeni comentare
#    @comment.save
#    if request.xhr?
#     respond_to { |format| format.js }
     flash.keep(:comment_id)
     flash.keep(:photo_id)

  end

  private

  def find_photo(photo_id)
    @photo = Photo.find(photo_id, :include => :section)

  end

end

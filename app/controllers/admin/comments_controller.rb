class Admin::CommentsController < Admin::ApplicationController
  
  def find_photo
    @photo = Photo.find(params[:photo_id])
  end

  def index
    @comments = Comment.approved
    @comments = @comments.paginate :page => params[:page],
      :per_page => 32
  end

  def approve_index
    @comments = Comment.not_approved
    @comments = @comments.paginate :page => params[:page],
      :per_page => 32
  end

  def approve
   #expire_index_page
    @comment = Comment.find(params[:id])
    @comment.approve = 0
    @comment.save
    redirect_to approve_index_admin_comments_url
  end


  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    #expire_index_page
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      if (params[:approval] == "approval")
        format.html { redirect_to(approve_index_admin_comments_url) }
      else
        format.html { redirect_to(admin_comments_url) }
      end
    end
  end
end

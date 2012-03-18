class Admin::TextboxesController < Admin::ApplicationController
  
  def index
    @textboxes = Textbox.all
  end

  def update
    @textbox = Textbox.find(params[:id])

    respond_to do |format|
      if @textbox.update_attributes(params[:textbox])
        format.html { redirect_to(:action => "index", :notice => 'Textbox was successfully updated.') }
      else
        format.html { render :action => "index" }
      end
    end
  end

end

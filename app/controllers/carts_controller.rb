class CartsController < ApplicationController
  layout "cart"

  def show
    # aby nam tohle fungovalo nezapomenout na has_many a tak v modelu
    find_cart
    @ordered_photos = @cart.ordered_photos.find(:all)
    
    @total_price = @cart.count_total_price
    
    if (session[:from_destroy] != "true")
      session[:last_photo_page] = request.env['HTTP_REFERER']
      session[:from_destroy] = "false"
    end
  end

  def count_price
    find_cart
    ordered_photo_id = params[:id]
    size_id = params[:size_id]
    @ordered_photo = OrderedPhoto.find(ordered_photo_id)

    # always check that customer changing his own orderedphoto!
    if (@ordered_photo.cart_id == @cart.id)
      @ordered_photo.price = @ordered_photo.photo.price
      @ordered_photo.print_size_id = size_id.to_i
      @ordered_photo.save
    else
      render :text => "xxx"
    end
    
    @total_price = @cart.count_total_price
    #logger.fatal "cena:"
    #logger.fatal @total_price

    respond_to do |format|
      format.js
    end
  end
 
end

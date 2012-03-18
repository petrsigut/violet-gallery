class OrderedPhotosController < ApplicationController
  def destroy
    find_cart
    @ordered_photo = OrderedPhoto.find(params[:id])

    # we need to check if we are deleting photo from our cart! (some evil user
    # could send us bad data)
    if (@ordered_photo.cart_id == @cart.id)
      @ordered_photo.destroy
    end

    session[:from_destroy] = "true"
    respond_to do |format|
      format.html { redirect_to(cart_path(@cart)) }
    end
  end

  def destroy_all
    find_cart
    @cart.ordered_photos.each {|ordered_photo| ordered_photo.destroy }

    session[:from_destroy] = "true"
    respond_to do |format|
      format.html { redirect_to(cart_path(@cart)) }
    end
  end


  def create
    find_cart
    
    @settings = Setting.find_by_name("default_print_size")

    @ordered_photo = OrderedPhoto.new
    @ordered_photo.photo_id = params[:id]
    @ordered_photo.cart_id = @cart.id
    @ordered_photo.price = @ordered_photo.photo.price
    @ordered_photo.print_size_id = @settings.value.to_i
    unless (@ordered_photo.price.nil?) # do not save photos with nil price
      @ordered_photo.save
    end  
    @ordered_photos = @cart.ordered_photos.find(:all)

    respond_to do |format|
      format.html {redirect_to(cart_path(@cart))}
      format.js
    end

  end


end

class Admin::CartsController < Admin::ApplicationController

  def index
    @carts = Cart.find(:all, :conditions => { :status => "ordered_by_customer"})
  end

  def in_printer
    @carts = Cart.find(:all, :conditions => { :status => "in_printer"})
  end

  def move_to_printer
    cart = Cart.find(params[:id])
    cart.status = "in_printer"
    cart.save
    redirect_to :action => 'in_printer'
  end

  def move_to_orders
    cart = Cart.find(params[:id])
    cart.status = "ordered_by_customer"
    cart.save
    redirect_to :action => 'index'
  end

  
end

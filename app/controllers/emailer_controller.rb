class EmailerController < ApplicationController
layout "cart"
#http://www.tutorialspoint.com/ruby-on-rails/rails-send-email.htm

   def show
     find_cart
     # avoiding creating new cart again and again after page reload
     if (@cart.status == "email_sending")
       @cart.status = "ordered_by_customer"
       session[:cart_id_old] = session[:cart_id]
       session[:cart_id] = nil
       @cart.save
     else
       @cart = Cart.find(session[:cart_id_old])
     end
       @ordered_photos = @cart.ordered_photos.find(:all)
       @total_price = @cart.count_total_price
       @print_office_bank_account = Setting.get_setting("print_office_bank_account")
   end

   def sendmail
     email = params["email"]

     sender = email["sender"]
     phone = email["phone"]
     message = email["message"]
     
     find_cart
     @cart.phone = phone
     cookies[:phone] = phone

     @cart.address = message
     cookies[:address] = message
     
     @cart.email = sender
     cookies[:email] = sender

     @cart.status = "email_sending"
     @cart.save

     ordered_photos = OrderedPhoto.find(:all, :conditions => ['cart_id = ?', @cart.id])
     # the price in ordered photos is copy of price of photos, because
     # author can change the price at any time, but it should not affect
     # ordered photos.
     commission_author = ordered_photos.sum(&:price)
 
     print_office_bank_account = Setting.get_setting("print_office_bank_account")
     author_bank_account = Setting.get_setting("author_bank_account")
     total_price = @cart.count_total_price
          

     Emailer.deliver_client(@cart, ordered_photos, print_office_bank_account, total_price)
     Emailer.deliver_author(@cart, ordered_photos, total_price, commission_author)
     #Emailer.deliver_printer(@cart, ordered_photos, print_office_bank_account, total_price, commission_author, author_bank_account)

     #return if request.xhr?
     #render :text => 'Message sent successfully'
     flash.now[:notice] =  t(:message_sent_successfully)
     redirect_to :action => 'sent'
   end
end

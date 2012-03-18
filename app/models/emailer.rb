class Emailer < ActionMailer::Base
  def client(cart, ordered_photos, print_office_bank_account, total_price, sent_at = Time.now)
      @recipients = cart.email
      @from = Setting.get_setting("author_email")
      @subject = "Fine-art print - "+self.default_url_options[:host]
      @sent_on = sent_at
          @body['host'] = self.default_url_options[:host]
  	  @body["cart"] = cart
   	  @body["print_office_bank_account"] = print_office_bank_account
   	  @body["ordered_photos"] = ordered_photos
   	  @body["total_price"] = total_price
   	  @body["author_email"] = Setting.get_setting("author_email")
   	  @body["author_phone"] = Setting.get_setting("author_phone")
      @headers = {}
  end  

  def author(cart, ordered_photos, total_price, commission_author, sent_at = Time.now)
      @recipients = Setting.get_setting("author_email")
      @from = cart.email
      @subject = "Fine-art print - "+@from.to_s
      @sent_on = sent_at
          @body['host'] = self.default_url_options[:host]
  	  @body["cart"] = cart
  	  @body["commission_author"] = commission_author
   	  @body["ordered_photos"] = ordered_photos
   	  @body["total_price"] = total_price
      @headers = {}
   end  

  def printer(cart, ordered_photos, print_office_bank_account, total_price, commission_author, author_bank_account, sent_at = Time.now)
      @recipients = Setting.get_setting("print_office_email")
      @from = cart.email
      @subject = "tisk fotografií - "+@from.to_s+self.default_url_options[:host]
      @sent_on = sent_at
          @body['host'] = self.default_url_options[:host]
  	  @body["cart"] = cart
   	  @body["print_office_bank_account"] = print_office_bank_account
   	  @body["author_bank_account"] = author_bank_account
  	  @body["commission_author"] = commission_author
   	  @body["ordered_photos"] = ordered_photos
   	  @body["total_price"] = total_price
   	  @body["author_email"] = Setting.get_setting("author_email")
   	  @body["author_phone"] = Setting.get_setting("author_phone")
      @headers = {}
   end  


end

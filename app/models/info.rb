class Info < ActionMailer::Base
def contact(phone, message, sent_at = Time.now)
      @subject = "dotaz na galerii"
      @recipients = "violet5@sigut.net"
      @from = "no-reply@sigut.net"
      @sent_on = sent_at
  	  @body["phone"] = phone
   	  @body["message"] = message
      @headers = {}
   end  

end

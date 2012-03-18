class InfoController < ApplicationController
  layout "gallery"

  def sendmail
     email = params["email"]
     phone = email["phone"]
     message = email["message"]
     
     #begin
       Info.deliver_contact(phone, message)
       flash.now[:notice] = "Zpráva úspěšně odeslána"
       render :vasegalerie
    # rescue
    #   logger.error("email error:"+message+phone)
    #   flash[:error] = "Zprávu se nepodařilo odeslat. Prosím kontaktujte nás e-mailem"
    # end
  end

  def contact
  end
  
end


module GuestbooksHelper
  def guestbook_name_and_web(guestbook)
      if (guestbook.web != "" and guestbook.web != "http://")
        link_to guestbook.name, guestbook.web
      else
        guestbook.name
      end
  end
end

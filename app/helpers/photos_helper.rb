module PhotosHelper
  def back_js_url(section) 
    if (section != nil)
      output = section_path(@photo.section, :page => params[:page])
    else
      output = root_path(:page => params[:page])
    end

  end
  def show_photo_navigation(section, ajax = false)
    Rails.logger.info "HEEEEEEEEEEEEEEEEEj"
    if (section == "_comment")
      output = content_tag(:li, (link_to t(:back),
             comments_path(:page => params[:page])))
      return output
    end
    if (section.nil?)
      section = Section.find_by_virtual_url("/")
      photo_next = @photo.next_morph(section)
      photo_prev = @photo.prev_morph(section)
 
      href_prev = photo_path(photo_prev, :page => params[:page], :id => "prev")
      href_next = photo_path(photo_next, :page => params[:page], :id => "next")
      section_id = nil

      output = content_tag(:li, (link_to t(:back),
             root_path(:page => params[:page])))

    else
      Rails.logger.info "Je to sekce"
      section = Section.find(section)
      Rails.logger.info section.title
      photo_next = @photo.next_morph(section)
      photo_prev = @photo.prev_morph(section)

      href_prev = section_photo_path(section, photo_prev, :page => params[:page])
      href_next = section_photo_path(section, photo_next, :page => params[:page])
      section_id = section.id
  
      output = content_tag(:li, (link_to t(:back),
             section_path(section, :page => params[:page])))

    end

   

    # then we show links either Ajax or static
    # Ajax
    if (ajax == true)

      if (photo_prev == @photo)
        output << content_tag(:li, t(:previous))
      else
        output << ajax_next_or_previous_link(t(:previous), "prev", photo_prev, section_id, href_prev)
      end

      if (photo_next == @photo)
        output << content_tag(:li, t(:next))
      else
        output << ajax_next_or_previous_link(t(:next), "next", photo_next, section_id, href_next)
      end
    # let's go static
    # we are in section
    elsif
      output << content_tag(:li, (link_to_unless_current t(:previous), href_prev,
                            :id => "prev"))
      output << content_tag(:li, (link_to_unless_current t(:next), href_next,
                           :id => "next"))
    end


  end


  def lowest_price(photo)
    output = "$"+photo.lowest_price.to_s+""
  end


  private


  def ajax_next_or_previous_link(link_name, link_dom_id, link_object, section_id, href)
    output = content_tag(:li, (link_to_remote link_name,
                  :url => {:action => :show,
                            :id => link_object,
                            :section_id => section_id,
                            :page => params[:page]},
                  :html => {:id => link_dom_id, :href => href},
                  :method => :get,
                  :complete => "

  var next_key = function(event){
    if(event.keyCode == Event.KEY_RIGHT) {
      if (Prototype.Browser.IE) {
        $('next').click();
      }
      else if (Prototype.Browser.ff3) {
        window.location.href = document.getElementById('next').href;
      }
      else {
        $('next').simulate('click');
      }
    }
  }

 var prev_key = function(event){
    if (event.keyCode == Event.KEY_LEFT) {
      if (Prototype.Browser.IE) {
        $('prev').click();
      }
      else if (Prototype.Browser.ff3) {
        window.location.href = document.getElementById('prev').href;
      }
      else {
        $('prev').simulate('click');
      }
    }
  }

  Form.getElements('new_comment').each(function(input)
  {
    Event.observe(input, 'focus', function(event){
      document.stopObserving('keydown');
    })
  });

  Form.getElements('new_comment').each(function(input) {
    Event.observe(input, 'blur', function(event){
      document.observe('keydown', prev_key);
      document.observe('keydown', next_key);
    })
  });


 ",

                  :after => "window.history.pushState(#{link_object.id}, 'title', #{link_object.id})"))

  end

  def just_edited(photo_id, edited_photo_id)
    if (photo_id.to_s == edited_photo_id)
      output = " edited"
    end
  end


end

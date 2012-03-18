# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

include WillPaginate::ViewHelpers

def default_content_for(name, &block)
  name = name.kind_of?(Symbol) ? ":#{name}" : name
  out = eval("yield #{name}", block.binding)
  concat(out || capture(&block))
end

def obligatory_field(field_name)
  "<strong>"+field_name+"*</strong>"
end

def nl2br(string)
  string.gsub("\n\r","<br>").gsub("\r", "").gsub("\n", "<br />")
end


def will_paginate_with_i18n(collection, options = {})
will_paginate_without_i18n(collection, options.merge(:previous_label => I18n.t(:previous), :next_label => I18n.t(:next)))
end

alias_method_chain :will_paginate, :i18n


  
  def photo_thumb(photo, url=nil)
      photo_path_fs = "/photos/_#{photo.id}.jpg"

      if url == nil
        image_tag(photo_path_fs, :height => "100",
                        :width => "150",
                        :alt => photo.title,
                        :class => "tphoto")
                        
      else
        link_to image_tag(photo_path_fs, :height => "100",
                        :width => "150",
                        :alt => photo.title,
                        :class => "tphoto"),
                        url
      end


  end


end

xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title(@title)
    xml.link(@site)
    xml.description(@description)
    xml.language(@locale)
      for photo in @photos
        xml.item do
          xml.title(photo.title)
          xml.description(photo.section.title)
          xml.author(@author)               
          xml.pubDate(photo.created_at.to_s(:rfc822))
          xml.link formatted_section_photo_url(photo.section.id, photo.id)
          xml.guid formatted_section_photo_url(photo.section.id, photo.id)
        end
      end
  }
}


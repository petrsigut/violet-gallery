class Photo < ActiveRecord::Base

  named_scope :limited, lambda {|*num| {:order =>'created_at DESC', :limit => num.empty? ? DEFAULT_LIMIT : num.first}}
  named_scope :unpublished, lambda { |section_id|
    { :conditions => ["section_id = #{section_id} and (publish_at >= NOW() or publish_at IS NULL)"] } }
  belongs_to :section
  belongs_to :author
  has_many :comments, :dependent => :destroy, :order => 'created_at DESC'
  has_many :ordered_photos, :dependent => :destroy

  validates_length_of :title, :minimum => 1, :message => 'Jméno musí být dlouhé alespoň 1 znak'

#   def my_logger
#     @@my_logger ||= Logger.new("#{RAILS_ROOT}/log/my.log")
#   end
   

  def path
    "/photos/#{self.id}.jpg"
  end

  def lowest_price
    self.price + PrintSize.minimum("price")
  end

  def is_in_cart
    self.ordered_photos.each do |ordered_photo|
      if (ordered_photo.cart.status.nil?)
         return true
         break
      end
    end
  end

  def is_ordered
    self.ordered_photos.each do |ordered_photo|
      if (ordered_photo.cart.status. == "ordered_by_customer")
         return true
         break
      end
    end
  end



  # plugin
  # http://svn.viney.net.nz/things/rails/plugins/acts_as_ordered/README
  # pro next a previous

  acts_as_ordered :order => 'created_at DESC', :scope => :section

  def next_morph(section)
    if (section.virtual == false)
      if (section.order == "ASC")
       photo = self.class.find :last, :include => :section,
         :conditions => ["photos.section_id = #{section.id} and photos.publish_at <= NOW()         and photos.created_at > ?", self.created_at],
         :order => "photos.created_at DESC"
      else
        photo = self.class.find :first, :include => :section,
         :conditions => ["photos.section_id = #{section.id} and photos.publish_at <= NOW()         and photos.created_at < ?", self.created_at],
         :order => "photos.created_at DESC"
      end

      
    elsif (section.virtual_name == "sections-all_photos")
      photo = self.class.find :first, :include => :section,
          :conditions => ['sections.builtin != 1 and photos.publish_at <= NOW() and photos.created_at < ?', self.created_at],
          :order => "photos.created_at DESC"
    elsif (section.virtual_name == "sections-most_viewed")
      photo = self.class.find :first, :include => :section,
          :conditions => ["photos.id != #{self.id} and photos.publish_at <= NOW() and sections.builtin != 1 and photos.view < ?", self.view],
          :order => "photos.view DESC"

    end
    if (photo.nil?)
      photo = self
    end
    photo

  end
  
  def prev_morph(section)
    if (section.virtual == false)
      if (section.order == "ASC")
       photo = self.class.find :first, :include => :section,
             :conditions => ["photos.section_id = #{section.id} and photos.publish_at <= NOW()         and photos.created_at < ?", self.created_at],
             :order => "photos.created_at DESC"
      else
        photo = self.class.find :last, :include => :section,
         :conditions => ["photos.section_id = #{section.id} and photos.publish_at <= NOW()         and photos.created_at > ?", self.created_at],
         :order => "photos.created_at DESC"
      end


    
    elsif (section.virtual_name == "sections-all_photos")
      photo = self.class.find :last, :include => :section,
          :conditions => ['sections.builtin != 1 and photos.publish_at <= NOW() and photos.created_at > ?', self.created_at],
          :order => "photos.created_at DESC"
    
    elsif (section.virtual_name == "sections-most_viewed")
      photo = self.class.find :last, :include => :section,
          :conditions => ["photos.id != #{self.id} and photos.publish_at <= NOW() and sections.builtin != 1 and photos.view > ?", self.view],
          :order => "photos.view DESC"

      #my_logger.info photo
    end

    if (photo.nil?)
      photo = self
    end
    photo

  end

  def increase_number_of_views(ip)
    @photo = Photo.find(id)
   
    # pokud na obrazek pristupujeme z jine IP adresy nebo uz od posledniho
    # pristupu ubehlo alespo 8 hodin tak zvysime pocet zobrazeni
    if (@photo.ip != ip) || (@photo.last_view < 8.hours.ago)
      @photo.view += 1
      @photo.ip = ip
      @photo.last_view = Time.now
      @photo.save
    end
  end

  # run write_file after save to db
  after_save :write_file
  # run delete_file method after removal from db
  after_destroy :delete_file
  
  # setter for form file field "image_file" (in the photo new form)
  # grabs the data and sets it to an instance variable.
  # we need this so the model is in db before file save,
  # so we can use the model id as filename.
  def image_file=(file_data)
    @file_data = file_data
  end

  def seconds_to_add=(seconds)
    @seconds = seconds
  end
  
  # write the @file_data data content to disk,
  # using the ALBUM_COVER_STORAGE_PATH constant.
  # saves the file with the filename of the model id
  # together with the file original extension
  def write_file
    # spustime jen kdyz mame nejake file_data => nespousti se pri kazde uprave
    # fotky
    if @file_data
      photo_path = "#{PHOTO_STORAGE_PATH}/#{id}.jpg" 
      thumb_path = "#{PHOTO_STORAGE_PATH}/_#{id}.jpg"
      File.open(photo_path, "w") do |file|
        file.write(@file_data.read)
        file.close
      end

      system("convert #{photo_path} -define jpeg:size=200x200  -thumbnail 150x100^ -gravity center -extent 150x100 -unsharp 0x1+0.4+0.0196 -quality 95 #{thumb_path}")
      
      image = MiniMagick::Image.open(photo_path)
      #logger.fatal "DELAM NAHLED!!!"
      #logger.fatal @seconds
      photo = Photo.find(id)
      photo.created_at += @seconds.seconds
      #logger.fatal photo.created_at
      photo.width = image[:width]
      photo.height = image[:height]
      photo.save
    end
  end

  
  def delete_file
    FileUtils.rm_rf("#{PHOTO_STORAGE_PATH}/#{id}.jpg")
    FileUtils.rm_rf("#{PHOTO_STORAGE_PATH}/_#{id}.jpg")
  end
  
end

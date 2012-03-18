require 'mini_magick'

desc "Iterate thru all photo and set they sizes - only for legacy photos in db"
task(:photos_sizes => :environment) do
  @photos = Photo.find(:all)

  basedir = 'public/photos/'
  Dir.chdir(basedir)

  @photos.each do |photo|
    #file = Dir.glob("#{photo.id}.jpg")
    image = MiniMagick::Image.open("#{photo.id}.jpg")
    photo.width = image[:width]
    photo.height = image[:height]
    puts photo.id
    photo.save
  end
end

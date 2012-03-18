desc "Iterate thru all photo and set different time to all (to make created_at DESC functional everytime)"
task(:repair_time => :environment) do
  @photos = Photo.find(:all, :order => 'created_at ASC, id DESC')

  @photos.each_with_index do |photo, i|
    puts i.to_s+". "
    photo.created_at += i.seconds
    puts photo.created_at
    photo.save
  end
end

desc "Deleting old carts"
task(:delete_old_carts => :environment) do
  # calling destroy to delete also ordered_photos
  puts "Carts before"
  puts Cart.all.count
  Cart.destroy_all(['status IS NULL and updated_at <?', 7.day.ago])
  puts "Carts after"
  puts Cart.all.count
end

desc "Deleting old sessions"
task(:delete_old_sessions => :environment) do
  puts "Sessions before"
  puts Session.all.count
  Session.delete_all(['updated_at <?', 7.day.ago])
  puts "Sessions after"
  puts Session.all.count
end

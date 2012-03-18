class Cart < ActiveRecord::Base
  has_many :ordered_photos, :dependent => :destroy

  def count_author_commission
    # http://www.rabbitcreative.com/2008/01/27/activerecords-sum-or-rails-enumerables-sum/
    self.ordered_photos.sum(:price)
  end

  def count_total_price
    @ordered_photos = OrderedPhoto.find(:all, :conditions => ['cart_id = ?', self.id])
    print_price = 0
    @ordered_photos.each do |ordered_photo|
      print_price += ordered_photo.print_size.price
    end
    @ordered_photos.sum(&:price) + print_price
  end
end

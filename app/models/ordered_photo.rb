class OrderedPhoto < ActiveRecord::Base
  belongs_to :cart
  belongs_to :photo
  belongs_to :print_size
end

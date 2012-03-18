module CartsHelper
  def select_size_tag(print_sizes, ordered_photo)
    output = select_tag(:id, options_for_select(print_sizes, :selected => ordered_photo.print_size_id), {:onchange => "#{remote_function(:url  => {:action => :count_price, :id => ordered_photo.id}, :method => :get, :with => "'size_id='+value")}" })
  end
      

end


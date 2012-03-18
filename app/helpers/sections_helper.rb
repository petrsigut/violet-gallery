module SectionsHelper

  def calendar_wedding(year_to_show,month_to_show)
    calendar(:year => year_to_show, :month => month_to_show,  :first_day_of_week => 1) do  |d|
      if @dates.include?(d) 
        [d.mday, {:class => "specialDay"}] 
      else 
        [d.mday, {:class => "normalDay"}]
      end
    end
  end

end

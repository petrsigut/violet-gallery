desc "Add basic textboxes like 'news' and 'do you like my photos'"
task(:add_basic_textboxes => :environment) do

  s = Textbox.new
  s.title = "Novinky & aktualizace"
  s.hardcoded_name = "news"
  s.save

  s = Textbox.new
  s.title = "Líbí se vám mé fotografie?"
  s.hardcoded_name = "like_my_photos"
  s.save



end

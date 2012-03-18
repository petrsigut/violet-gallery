desc "Create basic menu itself and basic items"
task(:add_basic_menu => :environment) do
  s = Section.new
  s.title = "Hlavní menu".to_s
  s.hardcoded = "main_menu".to_s
  s.virtual = 1
  s.show_menu = 0
  s.save

  s = Section.new
  s.title = "Vedlejší menu".to_s
  s.hardcoded = "side_menu".to_s
  s.virtual = 1
  s.show_menu = 0
  s.save

  main_menu = Section.find_by_hardcoded('main_menu')

  s = Section.new
  s.title = "Kontakt".to_s
  s.virtual = 1
  s.virtual_url = "/kontakt".to_s
  s.virtual_name = "info-kontakt".to_s
  s.parent_id = main_menu.id
  s.show_menu = 0
  s.save

  s = Section.new
  s.title = "Domů".to_s
  s.virtual = 1
  s.virtual_url = "/".to_s
  s.virtual_name = "sections-all_photos".to_s
  s.parent_id = main_menu.id
  s.show_menu = 0
  s.save

  s = Section.new
  s.title = "Vzkazy"
  s.virtual = 1
  s.virtual_url = "/guestbooks".to_s
  s.virtual_name = "guestbooks-index".to_s
  s.parent_id = main_menu.id
  s.show_menu = 0
  s.save


end

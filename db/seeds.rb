Counter.create :count => 0

Textbox.create :id => 1, :title => "NEWS", :hardcoded_name => "news"
Textbox.create :id => 2, :title => "LIKE", :hardcoded_name => "like_my_photos"
Textbox.create :id => 3, :title => "", :hardcoded_name => "banner_top", :publish => 0

Setting.create :name => "social_facebook", :value => "false"
Setting.create :name => "default_print_size", :value => "1"
Setting.create :name => "author_email", :value => "shipping@example.com"
Setting.create :name => "print_office_bank_account", :value => "Account number"
Setting.create :name => "print_office_email   ", :value => "shipping@example.com"
Setting.create :name => "gallery_name", :value => "Violet Gallery"
Setting.create :name => "meta_description", :value => "Violet Gallery"
Setting.create :name => "meta_keywords", :value => "violet, gallery, ruby on rails"
Setting.create :name => "author_phone", :value => "555 123 456"
Setting.create :name => "author_bank_account", :value => "Account number"
Setting.create :name => "show_events", :value => "true"
Setting.create :name => "show_orders", :value => "true"
Setting.create :name => "menu_banner", :value => "true"
Setting.create :name => "side_menu_position", :value => "top"
Setting.create :name => "violet5_version", :value => "PRO"
Setting.create :name => "show_author", :value => "false"
Setting.create :name => "show_sections_published", :value => "false"
Setting.create :name => "photos_per_page", :value => "20"
Setting.create :name => "can_change_photos_order", :value => "false"
Setting.create :name => "show_map", :value => "false"
Setting.create :name => "show_lang", :value => "true"
Setting.create :name => "show_remember_me", :value => "false"
Setting.create :name => "social_facebook", :value => "false"
Setting.create :name => "show_exif", :value => "false"

User.create(:login => "admin", :password => "admin", :password_confirmation => "admin", :email => "admin@example.com")

Section.create :id => 1, :title => "MAIN MENU", :not_comment => 1, :position => 1, :builtin => 0, :virtual => 1, :hardcoded => "main_menu", :folder => 0, :show_menu  => 1, :cssclass => "nowrap", :order => "DESC", :published => 1

Section.create :id => 2, :title => "SIDE (SECTION) MENU", :not_comment => 1, :position => 2, :builtin => 0, :virtual => 1, :hardcoded => "side_menu", :folder => 0, :show_menu  => 1, :cssclass => "nowrap", :order => "DESC", :published => 1
# on this ID 3 depends our root route
Section.create :id => 3, :title => "Home", :not_comment => 1, :position => 1, :builtin => 0, :parent_id => 1, :virtual => 1, :hardcoded => 0, :folder => 0, :show_menu  => 1, :virtual_url => "/", :virtual_name => "sections-all_photos", :cssclass => "nowrap", :order => "DESC", :published => 1

Section.create :id => 4, :title => "Messages", :not_comment => 1, :position => 2, :builtin => 0, :parent_id => 1, :virtual => 1, :hardcoded => 0, :folder => 0, :show_menu  => 1, :virtual_url => "/guestbooks", :virtual_name => "guestbooks-index", :cssclass => "nowrap", :order => "DESC", :published => 1

Section.create :id => 5, :title => "Contact", :not_comment => 1, :position => 3, :builtin => 0, :parent_id => 1, :virtual => 1, :hardcoded => 0, :folder => 0, :show_menu  => 1, :virtual_url => "/contact", :virtual_name => "info-contact", :cssclass => "nowrap", :order => "DESC", :published => 1

Section.create :id => 6, :title => "New comments", :not_comment => 1, :position => 3, :builtin => 0, :parent_id => 2, :virtual => 1, :hardcoded => 0, :folder => 0, :show_menu  => 0, :virtual_url => "/comments", :virtual_name => "comments-index", :cssclass => "nowrap", :order => "DESC", :published => 1

Section.create :id => 7, :title => "Portrait", :not_comment => 2, :position => 1, :builtin => 0, :parent_id => 2, :virtual => 0, :hardcoded => 0, :folder => 0, :show_menu  => 1, :cssclass => "nowrap", :order => "DESC", :published => 1

Section.create :id => 8, :title => "World", :not_comment => 0, :position => 2, :builtin => 0, :parent_id => 2, :virtual => 0, :hardcoded => 0, :folder => 0, :show_menu  => 1, :cssclass => "nowrap", :order => "DESC", :published => 1

# no photos can have the some 'created_at' time, it is used to get next/prev
# photo
Photo.create :id => 1, :title => 'Air / Nuno Pinheiro / LGPLv3', :section_id => 7, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:19'
Photo.create :id => 2, :title => 'Aghi / Matteo Nobile / LGPLv3', :section_id => 7, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:20'
Photo.create :id => 3,:title => 'Autumn / Piotr Adamek / LGPLv3', :section_id => 7, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:21'
Photo.create :id => 4,:title => 'Georgia Hobbs / Beach Reflecting Clouds / GPL', :section_id => 7, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:18'
Photo.create :id => 5,:title => 'Blue Wood / Jonas Arnfred / LGPLv3', :section_id => 7, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:22'
Photo.create :id => 6,:title => 'City at Night / Jorge Sandín / LGPLv3', :section_id => 7, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:23'
Photo.create :id => 7,:title => 'Code Poets Dream / Code Poet / LGPLv3', :section_id => 7, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:24'
Photo.create :id => 8,:title => 'Curls on Green / Joseph Connors / LGPLv3', :section_id => 7, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:25'
Photo.create :id => 9,:title => 'Damselfly / Risto Saukonpää / LGPLv3', :section_id => 7, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:26'
Photo.create :id => 10,:title => 'Field / Risto Saukonpää / LGPLv3', :section_id => 7, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:27'
Photo.create :id => 11,:title => 'Finally Summer in Germany / Kenneth Wimer / LGPLv3', :section_id => 7, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:28'
Photo.create :id => 12,:title => 'Fresh Morning / Pablo León-Asuero Moreno / LGPLv3', :section_id => 7, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:29'
Photo.create :id => 13,:title => 'Golden Ripples / Joseph Connors / LGPLv3', :section_id => 8, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:30'
Photo.create :id => 14,:title => 'Grass / Risto Saukonpää / LGPLv3', :section_id => 8, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:31'
Photo.create :id => 15,:title => 'Green Concentration / Joseph Connors / LGPLv3', :section_id => 8, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:32'
Photo.create :id => 16,:title => 'Hanami / Alexandre Courbot / LGPLv3', :section_id => 8, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:33'
Photo.create :id => 17,:title => 'JK Bridge at Night / Davi Lima / GPL', :section_id => 8, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:34'
Photo.create :id => 18,:title => 'Korea / Alexandre Courbot / LGPLv3', :section_id => 8, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:35'
Photo.create :id => 19,:title => 'Ladybuggin  / Rick Hanley / LGPLv3', :section_id => 8, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:36'
Photo.create :id => 20,:title => 'Yellow Flowers / Helena Świderska / LGPLv3', :section_id => 8, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:37'
Photo.create :id => 21,:title => 'Skeeter Hawk / Tracy Sprader / LGPLv3', :section_id => 8, :width => 900, :height => 720, :publish_at => '2012-03-17 23:05:19', :created_at => '2012-03-17 23:05:38'


#Comment.create :photo_id => 3, :name => "Peter", :msg => "First comment"


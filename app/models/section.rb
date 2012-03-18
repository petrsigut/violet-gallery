class Section < ActiveRecord::Base
  translates :title, :text
  has_many :photos
  
  validates_length_of :title, :minimum => 1, :message => 'Název musí být dlouhý alespoň 1 znak'

  acts_as_list :scope => :parent_id

  def children(order = :position, show_published = {:published => true})
    Section.find_all_by_parent_id(self.id, :order => order, :conditions => show_published)
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end


end

class Comment < ActiveRecord::Base
  # we have to limit what is visitor able to change
  attr_accessible :name, :msg

  named_scope :approved, :conditions => ['approve != 1'], :order => 'updated_at DESC'
  named_scope :approved_newest, :conditions => ['approve != 1'], :order => 'updated_at DESC',
    :limit => 1
  named_scope :not_approved, :conditions => ['approve = 1'], :order => 'created_at DESC'
  
  belongs_to :photo

  validates_length_of :name, :minimum => 1, :message => 'Jméno musí být dlouhé alespoň 1 znak'
  validates_length_of :msg, :minimum => 1, :message => 'Zpráva musí být dlouhá alespoň 1 znak'

  validate :msg_is_not_spam

  def msg_is_not_spam
    case
    when msg.match('link=http')
      errors.add(:msg, 'is spam')
    when msg.match('viagra')
      errors.add(:msg, 'is spam')
    when msg.match('amoxil')
      errors.add(:msg, 'is spam')
    when msg.match('prednisolone')
      errors.add(:msg, 'is spam')
    when msg.match('meclizine')
      errors.add(:msg, 'is spam')
    when msg.match('sinequan')
      errors.add(:msg, 'is spam')
    when msg.match('alendronic')
      errors.add(:msg, 'is spam')
    when msg.match('cavumox')
      errors.add(:msg, 'is spam')
    when msg.match('cialis')
      errors.add(:msg, 'is spam')
    when msg.match('health insurance')
      errors.add(:msg, 'is spam')
    when msg.match('carisoprodol')
      errors.add(:msg, 'is spam')
    end
  end


#  validates_exclusion_of :msg, :in => %w(viagra cialix), :message => 'Zpráva obsahuje zakázané slovo'
#  validates_each :msg do |record, attr, value|
#    record.errors.add attr, 'starts with z.' if value[0] == ?z
#  end


  def set_approval
    # section.not_comment == 2 -- comments in this section needs to be approved
    # comment.approve == 1 -- comment will wait to approval
    if (self.photo.section.not_comment == 2)
      self.approve = 1
    else
      self.approve = 0
    end
  end

end

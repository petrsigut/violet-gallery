class Guestbook < ActiveRecord::Base
  attr_accessible :name, :web, :msg

  validates_length_of :name, :minimum => 1
  validates_length_of :msg, :minimum => 1
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
    when msg.match('xanax')
      errors.add(:msg, 'is spam')
    when msg.match('insurance')
      errors.add(:msg, 'is spam')
    when msg.match('prednisone')
      errors.add(:msg, 'is spam')
    when msg.match('nexium')
      errors.add(:msg, 'is spam')
    end
  end
end

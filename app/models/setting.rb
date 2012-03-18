class Setting < ActiveRecord::Base
  def self.get_setting(name)
    @settings = Setting.find_by_name(name)
    @settings.value
  end
end

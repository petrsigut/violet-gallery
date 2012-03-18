# Detects user's browser.
# 
# Can be used in the layer view and the layer controller.
#
# Author::    Patrick Espake (mailto:patrickespake@gmail.com)
# Copyright:: Copyright (c) 2009
# License::   MIT

# This module detects user's browser.
# 
# Provides two methods:
#   browser_name
#   browser_is?
module PakeBrowserDetect
  # Checks the user's browser is
  #
  # Accepts the symbols:
  #   :firefox
  #   :opera
  #   :chrome
  #   :safari
  #   :ie
  #
  # Example of use:
  #   browser_is? :firefox
  def browser_is? name
    browser_name == name
  end

  # Name of the user's browser
  # 
  # Example of use:
  #   browser_name
  def browser_name
    ua = request.user_agent.downcase

    if ua =~ /firefox\/4/
      :is_able_to_ajax
    elsif ua =~ /firefox\/5/
      :is_able_to_ajax
    elsif ua =~ /firefox\/6/
      :is_able_to_ajax
    elsif ua =~ /firefox\/7/
      :is_able_to_ajax
    elsif ua =~ /firefox\/8/
      :is_able_to_ajax
    elsif ua =~ /firefox\/9/
      :is_able_to_ajax
    elsif ua =~ /firefox\/10/
      :is_able_to_ajax
    elsif ua =~ /firefox\/11/
      :is_able_to_ajax
    elsif ua =~ /firefox\/12/
      :is_able_to_ajax
    elsif ua =~ /firefox\/13/
      :is_able_to_ajax
    elsif ua =~ /firefox\/14/
      :is_able_to_ajax
    elsif ua =~ /chrome\/7/
      :is_able_to_ajax
    elsif ua =~ /chrome\/8/
      :is_able_to_ajax
    elsif ua =~ /chrome\/9/
      :is_able_to_ajax
    elsif ua =~ /chrome\/10/
      :is_able_to_ajax
    elsif ua =~ /chrome\/11/
      :is_able_to_ajax
    elsif ua =~ /chrome\/12/
      :is_able_to_ajax
    elsif ua =~ /chrome\/13/
      :is_able_to_ajax
    elsif ua =~ /chrome\/14/
      :is_able_to_ajax
    elsif ua =~ /chrome\/15/
      :is_able_to_ajax
    elsif ua =~ /chrome\/16/
      :is_able_to_ajax
    elsif ua =~ /chrome\/17/
      :is_able_to_ajax
    elsif ua =~ /chrome\/18/
      :is_able_to_ajax
    elsif ua =~ /chromium/
      :is_able_to_ajax
    elsif ua =~ /Version\/5.*Safari/
      :is_able_to_ajax
    elsif ua =~ /firefox\//
      :firefox
    elsif ua =~ /opera\//
      :opera
    elsif ua =~ /chrome\//
      :chrome
    elsif ua =~ /safari\//
      :safari
    elsif ua =~ /msie/
      :ie
    else
      nil
    end
  end
end

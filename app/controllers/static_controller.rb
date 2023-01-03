class StaticController < ApplicationController
  def home
    @reminders = Reminder.all
    @rem = Reminder.new
  end
  def check
  end
end

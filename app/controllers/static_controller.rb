class StaticController < ApplicationController
  def home
    @reminders = Reminder.all
    @rem = Reminder.new
  end
  def check
  end
  def transaction_summary
    @debts = Debt.all
    @cash_out = 0
    @change = 0
    sum = 0
    @debts.each do |d| 
      if d.cash_in != nil
        sum += d.cash_in
      end
      if(d.cash_out != nil)
        @cash_out += d.cash_out
      end
      if(d.change != nil)
        @change += d.change
      end
    end
      @cash_in = sum
  end
end

class Transaction < ApplicationRecord
    def self.get_daily_profit
        commands = Command.all.select {|x| x.created_at.strftime("%Y-%m-%d") == Date.today.strftime("%Y-%m-%d") }
        profit = 0
        commands.each do |command|
            if command.paid
                command.items.each do |item|
                    if item.bottles
                        profit += (item.drink.retail_price - (item.drink.buying_cost/item.drink.number_per_package))* (item.quantity == nil ? 0 : item.quantity)
                    else
                        profit += (item.drink.wholesale_price - item.drink.buying_cost)*(item.quantity == nil ? 0 : item.quantity)
                    end
                end
                puts command.client_name + ": " + profit.round(1).to_s
            end
        end
        return profit.round(1)
    end
end

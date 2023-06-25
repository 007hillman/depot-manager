class Transaction < ApplicationRecord
    def self.get_daily_profit(**args)
        puts args[:date].strftime
        commands = Command.all.select {|x| x.created_at.strftime("%Y-%m-%d") == Date.today.strftime("%Y-%m-%d") }
        profit = 0
        commands.each do |command|
            if command.amount_paid != 0.0
                command.items.each do |item|
                    if item.bottles
                        profit += ((item.drink.retail_price - item.discount )- (item.drink.buying_cost/item.drink.number_per_package))* (item.quantity == nil ? 0 : item.quantity)
                    else
                        profit += ((item.drink.wholesale_price - item.discount) - item.drink.buying_cost)*(item.quantity == nil ? 0 : item.quantity)
                    end
                    # puts item.drink.name + " : " + profit.round(1)
                end
            end
        end
        return profit.round(1)
    end
    def self.get_daily_transport
        transport_for_today = 0
        commands = Command.all.select {|x| x.created_at.strftime("%Y-%m-%d") == Date.today.strftime("%Y-%m-%d") }
        commands.each do |command|
            if command.transportation
                transport_for_today += Command.calculate_transport(command)
            end
        end
        return transport_for_today
    end
end

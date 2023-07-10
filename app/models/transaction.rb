class Transaction < ApplicationRecord
    def self.get_daily_profit(**args)
        
        if args[:date]
            commands = Command.all.select {|x| x.created_at.strftime("%Y-%m-%d") == args[:date].strftime("%Y-%m-%d") }
        else
            commands = Command.all.select {|x| x.created_at.strftime("%Y-%m-%d") == Date.today.strftime("%Y-%m-%d") }
        end
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
    def self.get_weekly_profit(**named_arguments)

        if named_arguments[:date]
            current_date = named_arguments[:date]
        else 
            current_date = Date.today
        end
        week_start = current_date - current_date.wday
        i = 1
        profit_hash = {}
        while week_start != current_date 
            profit_hash[week_start] = get_daily_profit(date: week_start)
            week_start = current_date - (current_date.wday - i)%7
            i += 1
        end
        profit_hash[current_date] = get_daily_profit(date: current_date)
        return profit_hash
    end
end

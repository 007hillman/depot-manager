class Transaction < ApplicationRecord
    def self.get_daily_profit(**args)
        profit = 0
        if args[:date]
            commands = Command.all.select {|x| x.created_at.strftime("%Y-%m-%d") == args[:date].strftime("%Y-%m-%d") }
        else
            commands = Command.all.select {|x| x.created_at.strftime("%Y-%m-%d") == Date.today.strftime("%Y-%m-%d") }
        end
        commands.each do |command|
            if command.amount_paid >= 0.0
               profit += get_profit_for_command(command)
            end
        end
        return profit + get_daily_transport 
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
        profit_hash[current_date] = get_daily_profit(date: current_date) -  AuxillaryPurchase.sum_auxillary_purchase_for_today(current_date.strftime("%Y-%m-%d")) - Drawing.sum_drawing_for_today(current_date.strftime("%Y-%m-%d"))
        return profit_hash
    end
    def self.get_profit_for_command(command)
        profit = 0
            command.items.each do |item|
            discount = item.discount == nil ? 0 : item.discount
                if item.bottles
                    profit += ((item.drink.retail_price - discount )- (item.drink.buying_cost/item.drink.number_per_package))* (item.quantity == nil ? 0 : item.quantity)
                else
                    profit += ((item.drink.wholesale_price - discount) - item.drink.buying_cost)*(item.quantity == nil ? 0 : item.quantity)
                end
            end
        return profit.round(1)
    end
end

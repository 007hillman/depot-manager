module CommandsHelper
    def command_total(c)
        sum = 0
        c.items.each do |item|
            if item.bottles
                sum += (item.quantity/item.drink.number_per_package) * item.drink.wholesale_price
            else
                sum += item.quantity * item.drink.wholesale_price
            end
        end
        return sum.round(1)
    end
    def total_sales(commands)
        amount = 0
        commands.each do |command|
            if(command.payment_method == "Cash payment" and command.amount_paid != nil)
                amount += command.amount_paid
            end
        end
        return amount
    end 

end

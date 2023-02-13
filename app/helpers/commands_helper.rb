module CommandsHelper
    def command_total(c)
        sum = 0
        c.items.each do |item|
            sum += item.quantity * item.drink.wholesale_price
        end
        return sum
    end
end

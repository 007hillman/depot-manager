module CommandsHelper
    def command_total(c)
        sum = 0
        c.items.each do |item|
            if item.bottles
                sum += (item.quantity) * item.drink.retail_price
            else
                if c.government
                    sum += item.quantity * item.drink.government_price
                else
                    sum += item.quantity * item.drink.wholesale_price
                end
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
    def guinness_money(commands)
        amount = 0
        commands.each do |command|
            if(command.payment_method == "Cash payment" and command.amount_paid != nil and command.amount_paid != 0.0)
                command.items.each do |item|
                    if(  Supplier.find(item.drink.supplyer).name == "Guinness Cameroun SA")
                        # if item.bottles
                        #     amount += ( ((item.drink.buying_cost * (item.quantity /item.drink.number_per_package))/command_total(command)) * command.amount_paid).round(1)
                        # else
                        #     amount += ( ((item.drink.buying_cost * item.quantity)/command_total(command)) * command.amount_paid).round(1)
                        # end
                    end
                end
            end
        end
        return amount
    end
    def brasseries_money(commands)
        amount = 0
        commands.each do |command|
            if(command.payment_method == "Cash payment" and command.amount_paid != nil and command.amount_paid != 0.0)
                command.items.each do |item|
                    if(  Supplier.find(item.drink.supplyer).name == "Brasseries du Cameroun SA")
                        # if item.bottles
                        #     amount += ( ((item.drink.buying_cost * (item.quantity /item.drink.number_per_package))/command_total(command)) * command.amount_paid).round(1)
                        # else
                        #     amount += ( ((item.drink.buying_cost * item.quantity)/command_total(command)) * command.amount_paid).round(1)
                        # end
                    end
                end
            end
        end
        return amount
    end
    def supermont_money(commands)
        amount = 0
        commands.each do |command|
            if(command.payment_method == "Cash payment" and command.amount_paid != nil and command.amount_paid != 0.0)
                command.items.each do |item|
                    if( Supplier.find(item.drink.supplyer).name == "Source du Pays (Supermont)")
                        # if item.bottles
                        #     amount += ( ((item.drink.buying_cost * (item.quantity /item.drink.number_per_package))/command_total(command)) * command.amount_paid).round(1)
                        # else
                        #     amount += ( ((item.drink.buying_cost * item.quantity)/command_total(command)) * command.amount_paid).round(1)
                        # end
                    end
                end
            end
        end
        return amount
    end
    def other_money(commands)
        amount = 0
        commands.each do |command|
            if(command.payment_method == "Cash payment" and command.amount_paid != nil and command.amount_paid != 0.0)
                command.items.each do |item|
                    sup_name = Supplier.find(item.drink.supplyer).name
                    if( sup_name != "Source du Pays (Supermont)" and sup_name != "Brasseries du Cameroun SA" and sup_name != "Guinness Cameroun SA")
                        # if item.bottles
                        #     amount += ( ((item.drink.buying_cost * (item.quantity /item.drink.number_per_package))/command_total(command)) * command.amount_paid).round(1)
                        # else
                        #     amount += ( ((item.drink.buying_cost * item.quantity)/command_total(command)) * command.amount_paid).round(1)
                        # end
                    end
                end
            end
        end
        return amount
    end
end

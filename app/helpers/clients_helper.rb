module ClientsHelper
    def total_owed(client_name)
        sum = 0
        @commands = Command.global_search(client_name)
        @commands.each do |command|
            sum += CommandsController.command_total(command) - command.amount_paid
        end
        return sum
    end
end

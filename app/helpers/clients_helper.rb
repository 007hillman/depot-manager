module ClientsHelper
    def total_owed(client_name)
        sum = 0
        @commands = Command.global_search(client_name)
        c= @commands.last
        sum = Client.total_owed(client_name, c.created_at)
        return sum
    end
end

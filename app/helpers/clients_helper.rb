module ClientsHelper
    include Pagy::Frontend

    def total_owed(client_name)
        sum = 0
        @commands = Command.global_search(client_name)
        if @commands
            c= @commands.last
            sum = Client.total_owed(client_name, c.created_at)
        end 
        return sum
    end
end

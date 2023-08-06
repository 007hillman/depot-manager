module ClientsHelper
    include Pagy::Frontend

    def total_owed(client_name)
        sum = 0
        @commands = Command.global_search(client_name)
            c= @commands.last
        if c != nil
            sum = Client.total_owed(client_name, c.created_at)
        end 
        return sum
    end
end

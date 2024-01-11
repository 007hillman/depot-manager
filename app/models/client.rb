class Client < ApplicationRecord
    has_many :payments, dependent: :destroy
    include PgSearch::Model
    pg_search_scope :global_search,
    against: [:name],
  using: {
    tsearch: { prefix: true }
}


def self.total_owed(**args)
  sum = 0
  if !args[:client_name]
    return sum
  end
  @commands = Command.global_search(args[:client_name])
  filtered_c = @commands.select {|x| x.paid == false}
  filtered_c.each do |command|
    command_total = Command.command_total(command)
    amount_paid = command.amount_paid == nil ? 0 : command.amount_paid
      if args[:command]
        if command == args[:command]
          break
        end
      end
        sum += command_total  - amount_paid
  end
  return sum 
end
def self.get_debtors 
  client_hash = {}
  Client.all.each do |client|
    client_hash[client.name] = 0
  end
  filtered_commands = Command.where(paid: false)
  filtered_commands.each do |command|
    command_total = Command.command_total(command)
    amount_paid = command.amount_paid == nil ? 0 : command.amount_paid
    if client_hash[command.client_name]
      client_hash[command.client_name] += command_total - amount_paid
    end
  end
  return client_hash.sort_by {|key| key}
end
end

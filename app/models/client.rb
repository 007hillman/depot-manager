class Client < ApplicationRecord
    has_many :payments, dependent: :destroy
    include PgSearch::Model
    pg_search_scope :global_search,
    against: [:name],
  using: {
    tsearch: { prefix: true }
}


def self.total_owed(client_name, sent_date)
  sum = 0
  @commands = Command.global_search(client_name)
  @commands.each do |command|
    command_total = Command.command_total(command)
    amount_paid = command.amount_paid == nil ? 0 : command.amount_paid
      if command.created_at.strftime("%Y-%m-%d") >= sent_date.strftime("%Y-%m-%d")
        break
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
  Command.all.each do |command|
    command_total = Command.command_total(command)
    amount_paid = command.amount_paid == nil ? 0 : command.amount_paid
    if client_hash[command.client_name] != nil
      client_hash[command.client_name] += command_total - amount_paid
    end
  end
  return client_hash
end
end

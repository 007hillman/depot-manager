class Client < ApplicationRecord
    has_many :payments, dependent: :destroy
    include PgSearch::Model
    pg_search_scope :global_search,
    against: [:name],
  using: {
    tsearch: { prefix: true }
}


def self.total_owed(client_name)
  sum = 0
  @commands = Command.global_search(client_name)
  @commands.each do |command|
      sum += Command.command_total(command) - (command.amount_paid == nil ? 0 : command.amount_paid)
  end
  return sum
end
end

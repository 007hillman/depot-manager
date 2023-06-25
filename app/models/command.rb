class Command < ApplicationRecord
 has_many :items , inverse_of: :command , dependent: :destroy
 has_many :payments, dependent: :destroy
 has_rich_text :remark
  accepts_nested_attributes_for :items,allow_destroy: true, reject_if: lambda {|attributes| attributes['quantity'].blank?}
  has_many :payments, dependent: :destroy
  include PgSearch::Model
  pg_search_scope :global_search,
  against: [:client_name],
using: {
  tsearch: { prefix: true }
}
def self.calculate_transport(command)
  transport  = 0
  command.items.each do |item|
    if item.bottles
      command.transportation ? transport += item.quantity * (item.drink.retail_price * 0.006) : transport += 0.0

    else
      command.transportation ? transport += item.quantity * (item.drink.wholesale_price * 0.006) : transport += 0.0
    end
  end
  transport = transport > 300 ? 300 : transport;
  transport = transport < 100 ? 100 : transport;
  return transport
end
def self.command_total(c)
  sum = 0
  transport_cost = calculate_transport(c)
  c.items.each do |item|
    quantity_requested_of_this_item = item.quantity == nil ? 0 : item.quantity
    discount_on_this_item = item.discount == nil ? 0 : item.discount
      if item.bottles
          sum += quantity_requested_of_this_item * (item.drink.retail_price - discount_on_this_item)
      else
          sum += quantity_requested_of_this_item* (item.drink.wholesale_price - discount_on_this_item)
      end
  end
  return (c.transportation ? sum + transport_cost : sum ).round(1)
end
def self.total_cost(c)
  sum = 0
  c.items.each do |item|
    quantity_of_the_item = item.quantity == nil ? 0 : item.quantity
      if item.bottles
          sum += quantity_of_the_item * (item.drink.buying_cost/item.drink.number_per_package)
      else
          sum += quantity_of_the_item * item.drink.buying_cost 
      end
  end
  return sum.round(1)
end

end

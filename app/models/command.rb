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
def self.command_total(c)
  sum = 0
  c.items.each do |item|
      if item.bottles
          sum += (item.quantity == nil ? 0 : item.quantity) * item.drink.retail_price
      else
          sum += (item.quantity == nil ? 0 : item.quantity) * item.drink.wholesale_price - ((item.quantity == nil ? 0 : item.quantity) * (item.discount == nil ? 0 : item.discount))
      end
  end
  return sum.round(1)
end
def self.total_cost(c)
  sum = 0
  c.items.each do |item|
      if item.bottles
          sum += (item.quantity == nil ? 0 : item.quantity) * (item.drink.buying_cost/item.drink.number_per_package)
      else
          sum += (item.quantity == nil ? 0 : item.quantity) * item.drink.buying_cost - ((item.quantity == nil ? 0 : item.quantity) * (item.discount == nil ? 0 : item.discount))
      end
  end
  return sum.round(1)
end
end

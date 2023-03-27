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
end

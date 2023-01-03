class Debt < ApplicationRecord
    include PgSearch::Model
    pg_search_scope :global_search,
    against: [:client_name],
  using: {
    tsearch: { prefix: true }
}
end

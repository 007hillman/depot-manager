class Drink < ApplicationRecord
    include PgSearch::Model
    pg_search_scope :global_search,
    against: [:name],
  using: {
    tsearch: { prefix: true }
}
end

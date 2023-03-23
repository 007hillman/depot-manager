class Client < ApplicationRecord
    has_many :payments, dependent: :destroy
    include PgSearch::Model
    pg_search_scope :global_search,
    against: [:name],
  using: {
    tsearch: { prefix: true }
}
end

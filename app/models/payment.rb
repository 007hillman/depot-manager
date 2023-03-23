class Payment < ApplicationRecord
  belongs_to :client
  belongs_to :command
  validates_presence_of :amount_paid, :command_id

end

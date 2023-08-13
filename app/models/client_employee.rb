class ClientEmployee < ApplicationRecord
  belongs_to :employee
  belongs_to :client
end

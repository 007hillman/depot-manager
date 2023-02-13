class Item < ApplicationRecord
  belongs_to :drink
  belongs_to :command
end

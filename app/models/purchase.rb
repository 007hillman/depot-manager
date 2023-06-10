class Purchase < ApplicationRecord
  belongs_to :supplier
  has_many :goods , inverse_of: :purchase , dependent: :destroy
  accepts_nested_attributes_for :goods,allow_destroy: true, reject_if: lambda {|attributes| attributes['quantity'].blank?}
end

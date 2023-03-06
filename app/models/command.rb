class Command < ApplicationRecord
 has_many :items , inverse_of: :command , dependent: :destroy
 has_many :payments, dependent: :destroy
 has_rich_text :remark
  accepts_nested_attributes_for :items,allow_destroy: true, reject_if: lambda {|attributes| attributes['quantity'].blank?}
end

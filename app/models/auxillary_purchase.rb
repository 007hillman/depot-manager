class AuxillaryPurchase < ApplicationRecord
	def self.sum_auxillary_purchase_for_today(sent_date)
		purchase = AuxillaryPurchase.last(100)
		filtered_purchases = purchase.select {|x| x.created_at.strftime("%Y-%m-%d") == sent_date }
		sum = 0
		filtered_purchases.each do |purch|
			sum += purch.amount_spent
		end
		return sum
	end
end

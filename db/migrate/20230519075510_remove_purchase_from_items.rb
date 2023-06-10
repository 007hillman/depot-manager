class RemovePurchaseFromItems < ActiveRecord::Migration[7.0]
  def change
	remove_column :items, :purchase_id
  end
end

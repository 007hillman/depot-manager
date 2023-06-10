class RemoveDrinkFromInventory < ActiveRecord::Migration[7.0]
  def change
	remove_column :inventories , :drink_id, :bigint
  end
end

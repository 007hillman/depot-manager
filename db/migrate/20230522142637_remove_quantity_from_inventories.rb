class RemoveQuantityFromInventories < ActiveRecord::Migration[7.0]
  def change
	remove_column :inventories, :quantity, :decimal
  end
end

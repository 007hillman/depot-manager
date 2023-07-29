class AddDrinkIdToInventory < ActiveRecord::Migration[7.0]
  def change
    add_column :inventories, :drink_id, :bigint
  end
end

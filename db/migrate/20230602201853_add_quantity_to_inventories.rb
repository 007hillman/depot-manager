class AddQuantityToInventories < ActiveRecord::Migration[7.0]
  def change
    add_column :inventories, :quantity, :decimal
  end
end

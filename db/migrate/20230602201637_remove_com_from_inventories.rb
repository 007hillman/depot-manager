class RemoveComFromInventories < ActiveRecord::Migration[7.0]
  def change
	remove_column :inventories, :com, :bigint
  end
end

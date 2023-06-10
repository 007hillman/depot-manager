class AddForeignIdToInventories < ActiveRecord::Migration[7.0]
  def change
    add_column :inventories, :foreign_id, :bigint
  end
end

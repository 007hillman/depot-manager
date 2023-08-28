class AddBottlesToGoods < ActiveRecord::Migration[7.0]
  def change
    add_column :goods, :bottles, :boolean
  end
end

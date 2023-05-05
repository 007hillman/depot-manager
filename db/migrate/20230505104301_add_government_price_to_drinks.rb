class AddGovernmentPriceToDrinks < ActiveRecord::Migration[7.0]
  def change
    add_column :drinks, :government_price, :decimal, default: 0
  end
end

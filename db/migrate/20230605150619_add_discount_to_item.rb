class AddDiscountToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :discount, :decimal, default: 0.0
  end
end

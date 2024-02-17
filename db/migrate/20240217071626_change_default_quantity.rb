class ChangeDefaultQuantity < ActiveRecord::Migration[7.0]
  def change
    change_column_default :items , :quantity, from: nil , to: 0
  end
end

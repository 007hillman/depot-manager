class AddChangeToDebts < ActiveRecord::Migration[7.0]
  def change
    add_column :debts, :change, :decimal
  end
end

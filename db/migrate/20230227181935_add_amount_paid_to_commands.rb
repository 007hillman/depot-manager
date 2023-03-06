class AddAmountPaidToCommands < ActiveRecord::Migration[7.0]
  def change
    add_column :commands, :amount_paid, :decimal , default: 0
  end
end

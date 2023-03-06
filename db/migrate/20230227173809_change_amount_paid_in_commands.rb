class ChangeAmountPaidInCommands < ActiveRecord::Migration[7.0]
  def change
    remove_column :commands, :amount_paid, :string
  end
  end

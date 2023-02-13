class AddAmountToCommand < ActiveRecord::Migration[7.0]
  def change
    add_column :commands, :amount_paid, :decimal
    add_column :commands, :payment_method, :string
  end
end

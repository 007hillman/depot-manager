class AddPaymentToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :payment, null: false, foreign_key: true
  end
end

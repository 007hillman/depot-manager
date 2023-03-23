class AddClientToPayment < ActiveRecord::Migration[7.0]
  def change
    add_reference :payments, :client, null: false, foreign_key: true
  end
end

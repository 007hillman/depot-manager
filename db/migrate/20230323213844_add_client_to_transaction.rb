class AddClientToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :client, null: false, foreign_key: true
  end
end

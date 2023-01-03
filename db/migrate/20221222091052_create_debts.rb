class CreateDebts < ActiveRecord::Migration[7.0]
  def change
    create_table :debts do |t|
      t.string :client_name
      t.decimal :cash_in , precision: 30, scale: 10
      t.decimal :cash_out, precision: 30, scale: 10

      t.timestamps
    end
  end
end

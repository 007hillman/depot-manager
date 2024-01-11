class CreateCashMovements < ActiveRecord::Migration[7.0]
  def change
    create_table :cash_movements do |t|
      t.decimal :amount
      t.boolean :cash_in
      t.boolean :cash_out
      t.string :person

      t.timestamps
    end
  end
end

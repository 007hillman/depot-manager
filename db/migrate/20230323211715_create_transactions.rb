class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :type, default: "Money"
      t.string :direction, default: "In"

      t.timestamps
    end
  end
end

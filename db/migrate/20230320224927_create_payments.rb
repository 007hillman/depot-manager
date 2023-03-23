class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :client, null: false, foreign_key: true
      t.decimal :amount_paid
      t.references :command, null: false, foreign_key: true

      t.timestamps
    end
  end
end

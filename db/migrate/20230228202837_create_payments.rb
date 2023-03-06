class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.belongs_to :command, null: false, foreign_key: true
      t.decimal :amount_paid

      t.timestamps
    end
  end
end

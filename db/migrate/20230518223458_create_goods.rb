class CreateGoods < ActiveRecord::Migration[7.0]
  def change
    create_table :goods do |t|
      t.references :purchase, null: false, foreign_key: true
      t.decimal :quantity
      t.references :drink, null: false, foreign_key: true

      t.timestamps
    end
  end
end

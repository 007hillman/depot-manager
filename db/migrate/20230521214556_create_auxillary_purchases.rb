class CreateAuxillaryPurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :auxillary_purchases do |t|
      t.string :purpose
      t.decimal :amount_spent

      t.timestamps
    end
  end
end

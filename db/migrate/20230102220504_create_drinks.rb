class CreateDrinks < ActiveRecord::Migration[7.0]
  def change
    create_table :drinks do |t|
      t.string :name
      t.string :supplyer
      t.string :size
      t.string :packaging
      t.boolean :alcoholic
      t.decimal :retail_price
      t.decimal :wholesale_price

      t.timestamps
    end
  end
end

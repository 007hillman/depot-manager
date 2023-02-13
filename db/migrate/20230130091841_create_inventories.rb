class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.references :drink, null: false, foreign_key: true
      t.decimal :quantity
      t.string :action

      t.timestamps
    end
  end
end

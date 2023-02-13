class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :drink, null: false, foreign_key: true
      t.belongs_to :command, null: false, foreign_key: true
      t.decimal :quantity

      t.timestamps
    end
  end
end

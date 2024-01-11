class CreateFixedAssets < ActiveRecord::Migration[7.0]
  def change
    create_table :fixed_assets do |t|
      t.string :asset_name
      t.decimal :asset_unit_price

      t.timestamps
    end
  end
end

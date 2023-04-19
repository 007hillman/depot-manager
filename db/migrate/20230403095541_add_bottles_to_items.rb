class AddBottlesToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :bottles, :boolean
  end
end

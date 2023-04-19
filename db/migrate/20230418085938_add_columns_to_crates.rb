class AddColumnsToCrates < ActiveRecord::Migration[7.0]
  def change
    add_column :crates, :brasseries_crates, :decimal
    add_column :crates, :guinness_crates, :decimal
  end
end

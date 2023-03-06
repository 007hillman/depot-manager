class AddCratesToCommand < ActiveRecord::Migration[7.0]
  def change
    add_column :commands, :brasseries_crates_given, :decimal, default: 0.0
    add_column :commands, :guinness_crates_given, :decimal, default: 0.0
  end
end

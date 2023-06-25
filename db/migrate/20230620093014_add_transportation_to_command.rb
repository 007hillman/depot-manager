class AddTransportationToCommand < ActiveRecord::Migration[7.0]
  def change
    add_column :commands, :transportation, :boolean
  end
end

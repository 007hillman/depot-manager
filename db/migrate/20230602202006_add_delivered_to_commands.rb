class AddDeliveredToCommands < ActiveRecord::Migration[7.0]
  def change
    add_column :commands, :delivered, :boolean
  end
end

class AddGovernmentToCommand < ActiveRecord::Migration[7.0]
  def change
    add_column :commands, :government, :boolean
  end
end

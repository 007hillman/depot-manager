class AddPaidToCommand < ActiveRecord::Migration[7.0]
  def change
    add_column :commands, :paid, :boolean
  end
end

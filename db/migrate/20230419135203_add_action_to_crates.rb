class AddActionToCrates < ActiveRecord::Migration[7.0]
  def change
    add_column :crates, :action, :string, default: "delivered"
  end
end

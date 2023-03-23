class AddLocationToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :location, :string, default: "Clerk's quarters ,Buea"
  end
end

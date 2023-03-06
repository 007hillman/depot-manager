class AddClientNameToPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :client_name, :string
  end
end

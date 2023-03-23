class RemoveClientNameFromPayment < ActiveRecord::Migration[7.0]
  def change
	remove_column :payments , :client_name
  end
end

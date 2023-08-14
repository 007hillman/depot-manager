class RemoveCommandFromPayment < ActiveRecord::Migration[7.0]
  def change
    remove_reference :payments, :command, null: false, foreign_key: true
  end
end

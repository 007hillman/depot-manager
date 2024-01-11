class AddBottlesToDrawing < ActiveRecord::Migration[7.0]
  def change
    add_column :drawings, :bottle, :boolean
  end
end

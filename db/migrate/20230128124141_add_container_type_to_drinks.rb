class AddContainerTypeToDrinks < ActiveRecord::Migration[7.0]
  def change
    add_column :drinks, :container_type, :string
  end
end

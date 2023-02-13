class AddPackagedNumberToDrinks < ActiveRecord::Migration[7.0]
  def change
    add_column :drinks, :number_per_package, :integer
  end
end

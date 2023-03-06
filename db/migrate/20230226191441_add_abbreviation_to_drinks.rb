class AddAbbreviationToDrinks < ActiveRecord::Migration[7.0]
  def change
    add_column :drinks, :abbreviation, :string, default: "ITM"
  end
end

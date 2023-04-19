class RemoveColumnFromCrates < ActiveRecord::Migration[7.0]
  def change
    remove_column :crates, :number_of_crates_given, :decimal
  end
end

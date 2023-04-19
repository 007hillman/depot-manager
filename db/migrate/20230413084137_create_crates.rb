class CreateCrates < ActiveRecord::Migration[7.0]
  def change
    create_table :crates do |t|
      t.references :client, null: false, foreign_key: true
      t.decimal :number_of_crates_given

      t.timestamps
    end
  end
end

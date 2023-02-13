class CreateCommands < ActiveRecord::Migration[7.0]
  def change
    create_table :commands do |t|
      t.string :client_name

      t.timestamps
    end
  end
end

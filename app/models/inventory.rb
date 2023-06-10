class Inventory < ApplicationRecord
  belongs_to :drink
  

  def self.add_invetory( purchase)
    purchase.goods.each do |good|
      Inventory.create(drink_id: good.drink_id , quantity: good.quantity, action: "purchased")
    end
  end
  def self.reduce_inventory(command)
    command.items.each do |item|
      Inventory.create(drink_id: item.drink_id , quantity: item.quantity, action: "sold")
    end
  end
end

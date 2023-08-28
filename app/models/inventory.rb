class Inventory < ApplicationRecord
  belongs_to :drink
  

  def self.add_inventory( purchase)
    purchase.goods.each do |good|
      drink = Drink.find(good.drink_id)
      quantum = 0
      if !good.bottles
        quantum = drink.number_per_package * good.quantity 
      else
        quantum = good.quantity 
      end
      Inventory.create(drink_id: good.drink_id , quantity: quantum, action: "purchased",  foreign_id: purchase.id)
    end
  end
  def self.reduce_inventory(command)
    command.items.each do |item|
      quantum = 0
      if !item.bottles
        quantum = item.drink.number_per_package * item.quantity 
      else
        quantum = item.quantity 
      end
      Inventory.create(drink_id: item.drink_id , quantity: quantum, action: "sold", foreign_id: command.id)
    end
  end
  def self.update_on_command (command)
    Inventory.where(foreign_id: command.id).destroy_all
    if command.created_at >= Date.strptime("29-07-2023","%Y-%m-%d") 
      reduce_inventory(command)
    end
  end
  def self.update_on_purchase_change(purchase)
    Inventory.where(foreign_id: purchase.id).destroy_all
    if purchase.created_at >= Date.strptime("29-07-2023","%Y-%m-%d") 
      Inventory.add_inventory(purchase)
    end
  end
  def self.delete_on_command_delete(command)
    Inventory.where(foreign_id: command.id).destroy_all
  end
  def self.delete_on_purchase_delete(purchase)
    Inventory.where(foreign_id: purchase.id).destroy_all
  end
end

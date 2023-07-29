class Inventory < ApplicationRecord
  belongs_to :drink
  

  def self.add_inventory( purchase)
    purchase.goods.each do |good|
      Inventory.create(drink_id: good.drink_id , quantity: good.quantity, action: "purchased",  foreign_id: purchase.id)
    end
  end
  def self.reduce_inventory(command)
    command.items.each do |item|
      Inventory.create(drink_id: item.drink_id , quantity: item.quantity, action: "sold", foreign_id: command.id)
    end
  end
  def self.update_on_command (command)
    Inventory.where(foreign_id: command.id).destroy_all
    if purchase.created_at.strftime("%Y-%m-%d") > "29-07-2023" 
      reduce_inventory(command)
    end
  end
  def self.update_on_purchase_change(purchase)
    Inventory.where(foreign_id: purchase.id).destroy_all
    if purchase.created_at.strftime("%Y-%m-%d") > "29-07-2023" 
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

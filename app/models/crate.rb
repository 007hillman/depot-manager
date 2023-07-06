class Crate < ApplicationRecord
  belongs_to :client

  def self.brassseries_crates_needed(command)
    crates_needed = 0
    command.items.each do |item|
      if(Supplier.find(item.drink.supplyer).name == "Brasseries du Cameroun SA" and item.drink.packaging == "crate")
      crates_needed += item.quantity
      end 
    end
    return crates_needed
  end
  def self.guinness_crates_needed(command)
    crates_needed = 0
    command.items.each do |item|
      if(Supplier.find(item.drink.supplyer).name == "Guinness Cameroun SA" and item.drink.packaging == "crate")
      crates_needed += item.quantity
      end 
    end
    return crates_needed 
  end
end

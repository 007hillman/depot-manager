class Payment < ApplicationRecord
  belongs_to :client
  
  def self.on_create_payment(**args)
    paid = args[:amount]
    commands = Command.where(paid: false, client_name: Client.global_search(Client.find(args[:client_id]).name)[0].name)
    commands.each do |command|
      command_total = Command.command_total(command)
      amount_paid = command.amount_paid
      if paid > 0
        if paid >= command_total - amount_paid then
          paid += amount_paid - command_total
          command.amount_paid = command_total 
          command.paid = true
        else
          command.amount_paid += paid
          paid = 0
        end
      end
      if command == commands.last and paid > 0
        command.amount_paid += paid
        command.paid = false
      end
      command.save!
    end
  end
  def self.on_update_payment(**args)
    on_delete_payment(client_id: args[:client_id],amount: args[:old_amount])
    on_create_payment(client_id: args[:client_id],amount: args[:amount])
  end
  def self.on_delete_payment(**args)
    paid = args[:amount]
    commands = Command.where(client_name: Client.find(args[:client_id]).name)
    commands.reverse.each do |command|
      command_total = Command.command_total(command)
      if paid > 0
        command.paid = false
        if paid >= command.amount_paid
          paid -= command.amount_paid
          command.amount_paid = 0
        else
          command.amount_paid -= paid
          paid = 0
        end
      end

      command.save!
    end
  end 
end

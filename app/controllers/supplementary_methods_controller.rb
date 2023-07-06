class SupplementaryMethodsController < ApplicationController
    def self.reinitialize_commands
        commands = Command.all
        commands.each do |command|
            if command.paid
                command.amount_paid = Command.command_total(command)
                command.save
            end
        end
    end
end

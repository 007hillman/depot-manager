class SupplementaryMethodsController < ApplicationController
    def reinitialize_commands
        commands = Command.all
        commands.each do |command|
            if command.paid
                command.amount_paid = Command.command_total(command)
                command.save
            end
        end
        respond_to do |format|
            format.html
            format.json 
        end
    end
end

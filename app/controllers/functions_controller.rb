class FunctionsController < ApplicationController
  def goods_consumption
    @goods_hash = {}
    if params[:search_date]
      @commands = Command.all.order("created_at DESC").select {|x| x.created_at.strftime("%Y-%m-%d") >= params[:search_date] }
      @commands.each do |command|
        command.items.each do |item|
          if !item.bottles 
            if @goods_hash[item.drink.name]
              @goods_hash[item.drink.name] += item.quantity
            else
              @goods_hash[item.drink.name] = item.quantity
            end
          end
        end
      end
    end
    puts @goods_hash
  end
end

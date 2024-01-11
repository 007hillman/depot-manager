class StaticController < ApplicationController
  before_action :authenticate_user!, only: [:accounting]
  def home
    @debtors = Client.get_debtors
  end
  def client
    client_name = Client.global_search(params[:name])
    if client_name.length != 0
      redirect_to controller: :clients , action: :show, id: client_name[0].id
    end
  end
  def crates
    @command = Command.find(params[:id])
  end
  def amount 
    @command = Command.find(params[:id])
  end


  def transaction_summary
    @debts = Debt.all
    @cash_out = 0
    @change = 0
    sum = 0
    @debts.each do |d| 
      if d.cash_in != nil
        sum += d.cash_in
      end
      if(d.cash_out != nil)
        @cash_out += d.cash_out
      end
      if(d.change != nil)
        @change += d.change
      end
    end
      @cash_in = sum
  end
  def command_total(c)
    sum = 0
    c.items.each do |item|
        sum += item.quantity * item.drink.wholesale_price
    end
    return sum
end
  def receipt
    sum_total = 0
    crates_needed = 0
    g_crates_needed = 0
    @command = Command.find(params[:id])
    pdf = Prawn::Document.new
    pdf.font "Courier"
    pdf.image "#{Rails.root}/app/assets/images/logo.png" , :at => [190, 720], :scale => 0.20 
    pdf.draw_text "Receipt: ", :at => [175,610], :size => 14, style: :bold
    pdf.font "Courier", size: 9
    pdf.bounding_box([175,600], :width => 400) do
      # pdf.text("The height of this box is #{pdf.bounds.height}")
      pdf.text('Date : ' +  @command.created_at.strftime("%A, %d %B %Y") )
      pdf.text('Company: BEDOTA Ent.')
      pdf.text('Location: Clerks quarters')
      pdf.text('Tel : (+237) 673-513-775')
      pdf.text('Email: tatawhillman@gmail.com')
      # pdf.text("Now the height of this box is #{pdf.bounds.height}")
    end
    pdf.bounding_box([175,540], :width => 400) do
      pdf.text('Client : ' + @command.client_name)
      if Client.global_search(@command.client_name)[0]
        pdf.text('Location: '+ Client.global_search(@command.client_name)[0].location.to_s)
      pdf.text('Tel : ' + Client.global_search(@command.client_name)[0].telephone.to_s )
      else
        pdf.text('Location: ')
        pdf.text('Tel : ')
      end
      pdf.text('Email: ')
    end
    pdf.draw_text '-------------------------------', at: [175,478]
    pdf.draw_text '-------------------------------', at: [175, 480]
    pdf.draw_text 'Items: ', style: :bold, size: 14, at: [175, 460]
    pdf.draw_text 'Code    |Qty  |UP    |TP', at: [175, 445]
    transport = 0
    
    pdf.bounding_box([175, 435], width: 400) do
      @command.items.each do |item|
        if item.bottles
          total_price = (item.quantity ) * (item.drink.retail_price * item.discount)
          sum_total += total_price

        else
          total_price = item.quantity * (item.drink.wholesale_price - item.discount)
          sum_total += total_price
        end

        if(Supplier.find(item.drink.supplyer).name == "Brasseries du Cameroun SA" and item.drink.packaging == "crate")
          crates_needed += item.quantity
        end
        if(Supplier.find(item.drink.supplyer).name == "Guinness Cameroun SA" and item.drink.packaging == "crate")
          g_crates_needed += item.quantity
        end
          if item.bottles 
            pdf.text item.drink.abbreviation + "| " + item.quantity.to_s + "| "+ (item.drink.retail_price - item.discount).to_s + "| " + ((item.drink.retail_price - item.discount)*item.quantity).to_s
          else
            pdf.text item.drink.abbreviation + "| " + item.quantity.to_s + "| "+ (item.drink.wholesale_price - item.discount).to_s + "| " + total_price.to_s
          end

      end
      if @command.transportation?
        transport = Command.calculate_transport(@command)
      end
      total_for_command = (Command.command_total(@command)) 
      total_owed = Client.total_owed(client_name: @command.client_name, command: @command)
      amount_paid = @command.amount_paid == nil ? 0.to_f : @command.amount_paid
      pdf.text 'transportation :           ' + transport.to_s
      sum_total += 0
      pdf.text 'SUB TOTAL                  ' + (total_for_command).to_s,  style: :bold
      pdf.text 'Amount paid :           ' + (amount_paid).to_s
      pdf.text  'Amount left :          '  + (total_for_command - (amount_paid)).to_s
      old_debt = total_owed

      pdf.text 'Old debt :            ' + old_debt.to_s 

      pdf.draw_text "GRAND TOTAL : " + (total_owed + total_for_command - amount_paid ).to_s , at: [0, pdf.cursor - 10], size: 11, style: :bold
    end
    pdf.bounding_box([175,pdf.cursor - 20], :width => 400) do
      pdf.text 'Number of different items :' + @command.items.count.to_s 
      pdf.text "--------------------------------"
      pdf.draw_text "--------------------------------", :at => [0, pdf.cursor + 2]
      pdf.text " "
      pdf.text 'Crates: ', style: :bold, size: 14
      pdf.text 'Brasseries: ', style: :bold, size: 11
      pdf.text 'crates needed : ' + crates_needed.to_s
      pdf.text 'crates given : ' + @command.brasseries_crates_given.to_s
      pdf.text '____________________'
      crates_owed = crates_needed - @command.brasseries_crates_given
      pdf.text 'crates owed : ' + crates_owed.to_s
      pdf.text 'Guinness: ', style: :bold, size: 11
      pdf.text 'crates needed : ' + g_crates_needed.to_s
      pdf.text 'crates given : ' + @command.guinness_crates_given.to_s
      pdf.text '____________________'
      g_crates_owed = g_crates_needed - @command.guinness_crates_given
      pdf.text 'crates owed : ' + g_crates_owed.to_s
      pdf.text 'Date : ' + @command.created_at.to_s 
    end
      
     

    respond_to do |format|
      format.pdf { send_data pdf.render,
        filename: "hillman-receipt.pdf",
        type: "application/pdf",
        disposition: :inline # or :attachment to download
      }
  end
end
  def accounting
    @profit_array = {}
      @profit_array = Transaction.get_weekly_profit
      @profit = Transaction.get_daily_profit(date: Date.today)
      @transport = Transaction.get_daily_transport
      @expenditure = AuxillaryPurchase.sum_auxillary_purchase_for_today(Date.today.strftime("%Y-%m-%d"))
      @drawing = Drawing.sum_drawing_for_today(Date.today.strftime("%Y-%m-%d"))
  end
  def generate_list
    drinks = Drink.all.order('supplyer desc').order("name asc")
    pdf = Prawn::Document.new
    pdf.font "Helvetica"
    pdf.bounding_box([0,720], :width => 1000) do
      pdf.image "#{Rails.root}/app/assets/images/logo.png" , :scale => 0.20 
      pdf.draw_text "BEDOTA ENTERPRISE PRICE LIST", :at => [120, pdf.cursor  + 50], style: :bold , size: 20
      pdf.draw_text 'Location: Clerks Quarters Buea , Tel: 681-448-117', :at => [120, pdf.cursor  + 35], style: :bold 
    end
    pdf.stroke_horizontal_rule
    pdf.move_down 20
    pdf.font "Courier", size: 9
      array = []
      array << ["Drink Name","Supplier","Quantity","Unit price"]      
      drinks.each do |drink|
        array <<  [drink.name, Supplier.find(drink.supplyer).name, "1 " + drink.packaging ,drink.wholesale_price.to_s]
      end
      pdf.table(
        array
      )
    respond_to do |format|
      format.pdf { send_data pdf.render,
        filename: "price_list.pdf",
        type: "application/pdf",
        disposition: :inline # or :attachment to download
      }
    end
  end
end

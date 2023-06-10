class StaticController < ApplicationController
  def home
    @reminders = Reminder.all
    @rem = Reminder.new
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
          transport += item.quantity * 20
        end

        if(Supplier.find(item.drink.supplyer).name == "Brasseries du Cameroun SA" and item.drink.packaging == "crate")
          crates_needed += item.quantity
        end
        if(Supplier.find(item.drink.supplyer).name == "Guinness Cameroun SA" and item.drink.packaging == "crate")
          g_crates_needed += item.quantity
        end

        pdf.text item.drink.abbreviation + "| " + item.quantity.to_s + "| "+ (item.drink.wholesale_price - item.discount).to_s + "| " + total_price.to_s
      end
      # pdf.text 'transportation :           ' + transport.to_s
      sum_total += 0
      pdf.text 'TOTAL:                 ' + (Command.command_total(@command)).to_s, style: :bold
      pdf.text 'Amount paid :           ' + (@command.amount_paid == nil ? 0.0 : @command.amount_paid).to_s
      pdf.text  'Amount left :          '  + (Command.command_total(@command) - (@command.amount_paid == nil ? 0 : @command.amount_paid)).to_s
      old_debt = (Client.total_owed(@command.client_name) - Command.command_total(@command) ) > 0 ? (Client.total_owed(@command.client_name) - Command.command_total(@command) ) : 0
      pdf.text 'Old debt :            ' + old_debt.to_s 
      pdf.draw_text "Total owed : " + (Client.total_owed(@command.client_name) + 0).to_s , at: [0, pdf.cursor - 10], size: 11, style: :bold

    end
    pdf.bounding_box([175,pdf.cursor - 10], :width => 400) do
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
  @profit = Transaction.get_daily_profit
end
end
# @command = Command.find(params[:id])
# @items = @command.items
# amount_p = 0
# if(@command.amount_paid != nil)
#   amount_p = @command.amount_paid
# end
# array = []
# array << ["<b>Item</b>", "<b>Unit Cost</b>", "<b>Quantity</b>", "<b>Amount</b>"]
# @items.each do |item|
#   array << [item.drink.name, item.drink.wholesale_price, item.quantity, item.drink.wholesale_price * item.quantity]
# end
# array << [nil, nil, "<b>TOTAL : </b>", command_total(@command)]
# array << [nil, nil, "<b>Amount paid</b>", @command.amount_paid]
# array << [nil, nil, "Change to be given on #{Date.today}", amount_p -  command_total(@command)]
# r = Receipts::Receipt.new(
#   details: [
#     ["Receipt Number", @command.id],
#     ["Date paid", Date.today],
#     ["Payment method", @command.payment_method]
#   ],
#   company: {
#     name: "<b>Company name : </b> BEDOTA Enterprises",
#     address: "<b>Location : </b>Clerk's quarters \n <b>City : </b>Buea",
#     email: "<b>Company email : </b>tatawhillman@gmail.com",
#     logo: File.expand_path("./app/assets/images/logo.png"),
#     logo_height: "48"
#   },
#   recipient: [
#     " <b>Client name : </b>" + @command.client_name,
#     "<b>Client's address : </b>",
#     "<b>Client's city : </b>Buea, South West Region",
#     nil,
#     "<b>Client's email : </b>"
#   ],
#   line_items: array ,
#   footer: "Thanks for doing business with us. Please contact us if you have any questions." 
# )

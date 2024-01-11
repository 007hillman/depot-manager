class CommandsController < ApplicationController
  before_action :set_command, only: %i[ show edit update destroy ]

  # GET /commands or /commands.json
  def update_inventory(c)
    if c.delivered
      
    end
  end
  def index
    if params[:query]
      @commands = Command.global_search(params[:query])
    elsif params[:search_date]
      @commands = Command.all.order("created_at DESC").select {|x| x.created_at.strftime("%Y-%m-%d") == params[:search_date] }
      @date = params[:search_date]
    elsif params[:message]
      if params[:message] == "all"
        @commands= Command.all.order("created_at DESC")
      end
    elsif params[:check]
      id = params[:check].to_i
      quanta = Inventory.get_quantity(id)
      @commands = quanta
    else
      @commands = Command.all.order("created_at DESC").select {|x| x.created_at.strftime("%Y-%m-%d") == Date.today.strftime("%Y-%m-%d") }
      @date = Date.today.strftime("%Y-%m-%d")
    end
      @result = generate_result_hash(@commands)
    respond_to do |format|
      format.html
      format.json { render json: { commands: @commands } }
    end
  end

  # GET /commands/1 or /commands/1.json
  def show
  end

  # GET /commands/new
  def new
    @command = Command.new
    1.times do
      @command.items.build
    end
  end

  # GET /commands/1/edit
  def edit
  end

  # POST /commands or /commands.json
  def create
    @command = Command.new(command_params)
    if command_params[:paid]  == 1.to_s
      @command.amount_paid = Command.command_total(@command) 
    end
    
    respond_to do |format|
      if @command.save
        Inventory.reduce_inventory(@command)
        format.html { redirect_to command_url(@command), notice: "Command was successfully created." }
        format.json { render :show, status: :created, location: @command }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @command.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commands/1 or /commands/1.json
  def update
    respond_to do |format|
      if @command.update(command_params)
        if @command.created_at.strftime("%Y-%m-%d") >= "2023-09-16"
          Inventory.update_on_command(@command)
        end
        if command_params[:paid] == 1.to_s
          c = Command.find(@command.id)
          c.amount_paid = Command.command_total(@command) 
          c.save
        else
          c = Command.find(@command.id)
          c.amount_paid = command_params[:amount_paid]
          c.save  
        end
        update_inventory(@command)
        format.html { redirect_to command_url(@command), notice: "Command was successfully updated." }
        format.json { render :show, status: :ok, location: @command }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @command.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commands/1 or /commands/1.json
  def destroy
    if @command.created_at.strftime("%Y-%m-%d") >= "2023-09-16"
      Inventory.delete_on_command_delete(@command)
    end
    @command.destroy
    respond_to do |format|
      format.html { redirect_to commands_url, notice: "Command was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def generate_result_hash(c)
    res = {}
    c.each do |command|
      command.items.each do |item|
        if res[Supplier.find(item.drink.supplyer).name]
          if res[Supplier.find(item.drink.supplyer).name][item.drink.name]
            res[Supplier.find(item.drink.supplyer).name][item.drink.name] += 1
          else
            res[Supplier.find(item.drink.supplyer).name][item.drink.name] = 1
          end
        else
          res[Supplier.find(item.drink.supplyer).name] = {}
          res[Supplier.find(item.drink.supplyer).name][item.drink.name] = 1
        end
      end
    end
    return res
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_command
      @command = Command.find(params[:id])
      
    end

    # Only allow a list of trusted parameters through.
    def command_params
      params.require(:command).permit(:transportation,:client_name,:amount_paid,:paid, :payment_method, :brasseries_crates_given, :guinness_crates_given,:government,:remark, :delivered ,items_attributes: [:id,:quantity,:drink_id,:discount,:bottles,:_destroy])
    end

end

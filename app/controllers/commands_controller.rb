class CommandsController < ApplicationController
  before_action :set_command, only: %i[ show edit update destroy ]

  # GET /commands or /commands.json
  def index
    if params[:query]
      @commands = Command.global_search(params[:query])
    else
      @commands = Command.all.order("created_at DESC")
    end
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
    
    respond_to do |format|
      if @command.save
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
    @command.destroy

    respond_to do |format|
      format.html { redirect_to commands_url, notice: "Command was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_command
      @command = Command.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def command_params
      params.require(:command).permit(:client_name,:amount_paid, :payment_method, :brasseries_crates_given, :guinness_crates_given, items_attributes: [:id,:quantity,:drink_id,:_destroy])
    end
end

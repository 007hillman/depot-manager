class DebtsController < ApplicationController
  before_action :set_debt, only: %i[ show edit update destroy ]

  # GET /debts or /debts.json
  def index
    if params[:query]
      @debts= Debt.global_search(params[:query])
    else
      @debts = Debt.all
    end
    respond_to do |format|
      format.html
      format.json { render json: { debts: @debts } } 
    end
  end
  # GET /debts/1 or /debts/1.json
  def show
  end

  # GET /debts/new
  def new
    @debt = Debt.new
    @clients = Client.all
  end

  # GET /debts/1/edit
  def edit
    @clients = Client.all

  end

  # POST /debts or /debts.json
  def create
    if Client.where(name: (params[:client_name])) == nil
      n = Client.new
      n.name = params[:client_name]
      n.save
    end
    @debt = Debt.new(debt_params)

    respond_to do |format|
      if @debt.save
        format.html { redirect_to debts_url, notice: "Debt was successfully created." }
        format.json { render :show, status: :created, location: @debt }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debts/1 or /debts/1.json
  def update
    respond_to do |format|
      if @debt.update(debt_params)
        format.html { redirect_to debt_url(@debt), notice: "Debt was successfully updated." }
        format.json { render :show, status: :ok, location: @debt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debts/1 or /debts/1.json
  def destroy
    @debt.destroy

    respond_to do |format|
      format.html { redirect_to debts_url, notice: "Debt was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debt
      @debt = Debt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def debt_params
      params.require(:debt).permit(:client_name, :cash_in,:change, :cash_out)
    end
end

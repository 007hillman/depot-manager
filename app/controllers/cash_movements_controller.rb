class CashMovementsController < ApplicationController
  before_action :set_cash_movement, only: %i[ show edit update destroy ]

  # GET /cash_movements or /cash_movements.json
  def index
    @cash_movements = CashMovement.all
  end

  # GET /cash_movements/1 or /cash_movements/1.json
  def show
  end

  # GET /cash_movements/new
  def new
    @cash_movement = CashMovement.new
  end

  # GET /cash_movements/1/edit
  def edit
  end

  # POST /cash_movements or /cash_movements.json
  def create
    if (params[:cash_in] and params[:cash_out]) or (!params[:cash_in] and !params[:cash_out])

    end
    @cash_movement = CashMovement.new(cash_movement_params)

    respond_to do |format|
      if @cash_movement.save
        format.html { redirect_to cash_movement_url(@cash_movement), notice: "Cash movement was successfully created." }
        format.json { render :show, status: :created, location: @cash_movement }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cash_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cash_movements/1 or /cash_movements/1.json
  def update
    respond_to do |format|
      if @cash_movement.update(cash_movement_params)
        format.html { redirect_to cash_movement_url(@cash_movement), notice: "Cash movement was successfully updated." }
        format.json { render :show, status: :ok, location: @cash_movement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cash_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cash_movements/1 or /cash_movements/1.json
  def destroy
    @cash_movement.destroy

    respond_to do |format|
      format.html { redirect_to cash_movements_url, notice: "Cash movement was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cash_movement
      @cash_movement = CashMovement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cash_movement_params
      params.require(:cash_movement).permit(:amount, :cash_in, :cash_out, :person)
    end
end

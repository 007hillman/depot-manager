class AuxillaryPurchasesController < ApplicationController
  before_action :set_auxillary_purchase, only: %i[ show edit update destroy ]

  # GET /auxillary_purchases or /auxillary_purchases.json
  def index
    @auxillary_purchases = AuxillaryPurchase.all
  end

  # GET /auxillary_purchases/1 or /auxillary_purchases/1.json
  def show
  end

  # GET /auxillary_purchases/new
  def new
    @auxillary_purchase = AuxillaryPurchase.new
  end

  # GET /auxillary_purchases/1/edit
  def edit
  end

  # POST /auxillary_purchases or /auxillary_purchases.json
  def create
    @auxillary_purchase = AuxillaryPurchase.new(auxillary_purchase_params)

    respond_to do |format|
      if @auxillary_purchase.save
        format.html { redirect_to auxillary_purchase_url(@auxillary_purchase), notice: "Auxillary purchase was successfully created." }
        format.json { render :show, status: :created, location: @auxillary_purchase }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @auxillary_purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /auxillary_purchases/1 or /auxillary_purchases/1.json
  def update
    respond_to do |format|
      if @auxillary_purchase.update(auxillary_purchase_params)
        format.html { redirect_to auxillary_purchase_url(@auxillary_purchase), notice: "Auxillary purchase was successfully updated." }
        format.json { render :show, status: :ok, location: @auxillary_purchase }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @auxillary_purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auxillary_purchases/1 or /auxillary_purchases/1.json
  def destroy
    @auxillary_purchase.destroy

    respond_to do |format|
      format.html { redirect_to auxillary_purchases_url, notice: "Auxillary purchase was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auxillary_purchase
      @auxillary_purchase = AuxillaryPurchase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def auxillary_purchase_params
      params.require(:auxillary_purchase).permit(:purpose, :amount_spent)
    end
end

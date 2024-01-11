class FixedAssetsController < ApplicationController
  before_action :set_fixed_asset, only: %i[ show edit update destroy ]

  # GET /fixed_assets or /fixed_assets.json
  def index
    @fixed_assets = FixedAsset.all
  end

  # GET /fixed_assets/1 or /fixed_assets/1.json
  def show
  end

  # GET /fixed_assets/new
  def new
    @fixed_asset = FixedAsset.new
  end

  # GET /fixed_assets/1/edit
  def edit
  end

  # POST /fixed_assets or /fixed_assets.json
  def create
    @fixed_asset = FixedAsset.new(fixed_asset_params)

    respond_to do |format|
      if @fixed_asset.save
        format.html { redirect_to fixed_asset_url(@fixed_asset), notice: "Fixed asset was successfully created." }
        format.json { render :show, status: :created, location: @fixed_asset }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fixed_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fixed_assets/1 or /fixed_assets/1.json
  def update
    respond_to do |format|
      if @fixed_asset.update(fixed_asset_params)
        format.html { redirect_to fixed_asset_url(@fixed_asset), notice: "Fixed asset was successfully updated." }
        format.json { render :show, status: :ok, location: @fixed_asset }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fixed_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fixed_assets/1 or /fixed_assets/1.json
  def destroy
    @fixed_asset.destroy

    respond_to do |format|
      format.html { redirect_to fixed_assets_url, notice: "Fixed asset was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fixed_asset
      @fixed_asset = FixedAsset.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fixed_asset_params
      params.require(:fixed_asset).permit(:asset_name, :asset_unit_price)
    end
end

class InventoriesController < ApplicationController
  before_action :set_inventory, only: %i[ show edit update destroy ]

  # GET /inventories or /inventories.json
  def index
    @inventories = Inventory.all.order("created_at desc")
    @drinks_hash = {}
    if params[:command] == "initialize"
      Inventory.delete_all
    end
    if params[:supplyer]
      Drink.where(supplyer: params[:supplyer]).order(:name).each do |drink|
        @drinks_hash[drink.name] = 0
      end
    else
      Drink.all.order(:name).each do |drink|
        @drinks_hash[drink.name] = 0
      end
    end
    @inventories.each do |entry|
      drink = Drink.find(entry.drink_id).name
      if entry.action == "purchased" and @drinks_hash[drink] != nil
        @drinks_hash[drink] += (entry.quantity)
      elsif entry.action == "sold"  and @drinks_hash[drink] != nil
        @drinks_hash[drink] -= entry.quantity
      end
    end
    # counting drinks in packages
    @palette_hash = {}
    @remainder_hash = {}
    @drinks_hash.each do |name, quantity|
      drink_quantity = Drink.where(name: name)[0].number_per_package
      @palette_hash[name] = (quantity / drink_quantity).to_i
      @remainder_hash[name] = quantity % drink_quantity
    end
  end


  # GET /inventories/1 or /inventories/1.json
  def show
  end

  # GET /inventories/new
  def new
    @inventory = Inventory.new
  end

  # GET /inventories/1/edit
  def edit
  end

  # POST /inventories or /inventories.json
  def create
    @inventory = Inventory.new(inventory_params)

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to inventory_url(@inventory), notice: "Inventory was successfully created." }
        format.json { render :show, status: :created, location: @inventory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventories/1 or /inventories/1.json
  def update
    respond_to do |format|
      if @inventory.update(inventory_params)
        format.html { redirect_to inventory_url(@inventory), notice: "Inventory was successfully updated." }
        format.json { render :show, status: :ok, location: @inventory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1 or /inventories/1.json
  def destroy
    @inventory.destroy

    respond_to do |format|
      format.html { redirect_to inventories_url, notice: "Inventory was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory
      @inventory = Inventory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def inventory_params
      params.require(:inventory).permit(:drink_id, :quantity, :action)
    end
end

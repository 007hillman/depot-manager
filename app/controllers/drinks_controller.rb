class DrinksController < ApplicationController
  before_action :set_drink, only: %i[ show edit update destroy ]

  # GET /drinks or /drinks.json
  def index
    if params[:query]
      @pagy, @drinks= pagy(Drink.global_search(params[:query]).order("name"))
    else
      @pagy, @drinks = pagy(Drink.all.order("name"))
    end
    if turbo_frame_request?
      render partial: "bands", locals: { bands: @bands }
    else
      render :index
    end
  end

  # GET /drinks/1 or /drinks/1.json
  def show
    @commands = Command.all.order("created_at desc")
  end

  # GET /drinks/new
  def new
    @drink = Drink.new
  end

  # GET /drinks/1/edit
  def edit
  end

  # POST /drinks or /drinks.json
  def create
    @drink = Drink.new(drink_params)

    respond_to do |format|
      if @drink.save
        format.html { redirect_to drink_url(@drink), notice: "Drink was successfully created." }
        format.json { render :show, status: :created, location: @drink }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @drink.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drinks/1 or /drinks/1.json
  def update
    respond_to do |format|
      if @drink.update(drink_params)
        SupplementaryMethodsController.reinitialize_commands
        format.html { redirect_to drink_url(@drink), notice: "Drink was successfully updated." }
        format.json { render :show, status: :ok, location: @drink }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @drink.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drinks/1 or /drinks/1.json
  def destroy
    @drink.destroy

    respond_to do |format|
      format.html { redirect_to drinks_url, notice: "Drink was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drink
      @drink = Drink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def drink_params
      params.require(:drink).permit(:name, :supplyer, :size, :packaging, :alcoholic, :retail_price, :wholesale_price, :number_per_package, :container_type,:safe_quantity,:government_price, :abbreviation, :buying_cost)
    end
end

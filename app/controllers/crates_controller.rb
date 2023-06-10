class CratesController < ApplicationController
  before_action :set_crate, only: %i[ show edit update destroy ]

  # GET /crates or /crates.json
  def index
    @crates = Crate.all
  end

  # GET /crates/1 or /crates/1.json
  def show
  end

  # GET /crates/new
  def new
    @crate = Crate.new
  end

  # GET /crates/1/edit
  def edit
  end

  # POST /crates or /crates.json
  def create
    @crate = Crate.new(crate_params)

    respond_to do |format|
      if @crate.save
        format.html { redirect_to crate_url(@crate), notice: "Crate was successfully created." }
        format.json { render :show, status: :created, location: @crate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @crate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crates/1 or /crates/1.json
  def update
    respond_to do |format|
      if @crate.update(crate_params)
        format.html { redirect_to crate_url(@crate), notice: "Crate was successfully updated." }
        format.json { render :show, status: :ok, location: @crate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @crate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crates/1 or /crates/1.json
  def destroy
    @crate.destroy

    respond_to do |format|
      format.html { redirect_to crates_url, notice: "Crate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crate
      @crate = Crate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def crate_params
      params.require(:crate).permit(:client_id, :brasseries_crates, :guinness_crates, :action)
    end
end

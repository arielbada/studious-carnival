class LocalidadesController < ApplicationController
  before_action :set_localidad, only: [:show, :edit, :update, :destroy]

  # GET /localidades
  # GET /localidades.json
  def index
    @localidades = Localidad.all
  end

  # GET /localidades/1
  # GET /localidades/1.json
  def show
  end

  # GET /localidades/new
  def new
    @localidad = Localidad.new
  end

  # GET /localidades/1/edit
  def edit
  end

  # POST /localidades
  # POST /localidades.json
  def create
    @localidad = Localidad.new(localidad_params)

    respond_to do |format|
      if @localidad.save
        format.html { redirect_to @localidad, notice: 'Localidad was successfully created.' }
        format.json { render :show, status: :created, location: @localidad }
      else
        format.html { render :new }
        format.json { render json: @localidad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /localidades/1
  # PATCH/PUT /localidades/1.json
  def update
    respond_to do |format|
      if @localidad.update(localidad_params)
        format.html { redirect_to @localidad, notice: 'Localidad was successfully updated.' }
        format.json { render :show, status: :ok, location: @localidad }
      else
        format.html { render :edit }
        format.json { render json: @localidad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /localidades/1
  # DELETE /localidades/1.json
  def destroy
    @localidad.destroy
    respond_to do |format|
      format.html { redirect_to localidades_url, notice: 'Localidad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_localidad
      @localidad = Localidad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def localidad_params
      params.require(:localidad).permit(:localidad, :region_educativa, :nodo)
    end
end

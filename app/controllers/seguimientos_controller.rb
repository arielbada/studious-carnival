class SeguimientosController < ApplicationController
  before_action :set_seguimiento, only: [:show, :edit, :update, :destroy]
  #before_action :set_seguimiento, only: [:show, :update, :destroy]

  # GET /seguimientos
  # GET /seguimientos.json
  def index
    @seguimientos = Seguimiento.all
	@seguimientos = Seguimiento.filter(params, @seguimientos)
	@seguimientos = @seguimientos.order(fecha_acta: :desc)
  end

  # GET /seguimientos/1
  # GET /seguimientos/1.json
  def show
  end

  # GET /seguimientos/new
  def new
    @seguimiento = Seguimiento.new
  end

  # GET /seguimientos/1/edit
  def edit
  end

  # POST /seguimientos
  # POST /seguimientos.json
  def create
    @seguimiento = Seguimiento.new(seguimiento_params)

    respond_to do |format|
      if @seguimiento.save
        format.html { redirect_to @seguimiento, notice: 'Seguimiento was successfully created.' }
        format.json { render :show, status: :created, location: @seguimiento }
      else
        format.html { render :new }
        format.json { render json: @seguimiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seguimientos/1
  # PATCH/PUT /seguimientos/1.json
  def update
    respond_to do |format|
      if @seguimiento.update(seguimiento_params)
        format.html { redirect_to @seguimiento, notice: 'Seguimiento was successfully updated.' }
        format.json { render :show, status: :ok, location: @seguimiento }
      else
        format.html { render :edit }
        format.json { render json: @seguimiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seguimientos/1
  # DELETE /seguimientos/1.json
  def destroy
    @seguimiento.destroy
    respond_to do |format|
      format.html { redirect_to seguimientos_url, notice: 'Seguimiento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seguimiento
      @seguimiento = Seguimiento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seguimiento_params
      params.require(:seguimiento).permit(:alumno_id, :fecha_acta, :seccion_id, :estado, :calificacion)
    end
end

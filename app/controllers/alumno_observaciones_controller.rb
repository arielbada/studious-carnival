class AlumnoObservacionesController < ApplicationController
  before_action :set_alumno_observacion, only: [:show, :edit, :update, :destroy]

  # GET /alumno_observaciones
  # GET /alumno_observaciones.json
  def index
    @alumno_observaciones = AlumnoObservacion.all
  end

  # GET /alumno_observaciones/1
  # GET /alumno_observaciones/1.json
  def show
  end

  # GET /alumno_observaciones/new
  def new
    @alumno_observacion = AlumnoObservacion.new
  end

  # GET /alumno_observaciones/1/edit
  def edit
  end

  # POST /alumno_observaciones
  # POST /alumno_observaciones.json
  def create
    @alumno_observacion = AlumnoObservacion.new(alumno_observacion_params)

    respond_to do |format|
      if @alumno_observacion.save
        format.html { redirect_to @alumno_observacion, notice: 'Alumno observacion was successfully created.' }
        format.json { render :show, status: :created, location: @alumno_observacion }
      else
        format.html { render :new }
        format.json { render json: @alumno_observacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alumno_observaciones/1
  # PATCH/PUT /alumno_observaciones/1.json
  def update
    respond_to do |format|
      if @alumno_observacion.update(alumno_observacion_params)
        format.html { redirect_to @alumno_observacion, notice: 'Alumno observacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @alumno_observacion }
      else
        format.html { render :edit }
        format.json { render json: @alumno_observacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alumno_observaciones/1
  # DELETE /alumno_observaciones/1.json
  def destroy
    @alumno_observacion.destroy
    respond_to do |format|
      format.html { redirect_to alumno_observaciones_url, notice: 'Alumno observacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alumno_observacion
      @alumno_observacion = AlumnoObservacion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alumno_observacion_params
      params.require(:alumno_observacion).permit(:observacion)
    end
end

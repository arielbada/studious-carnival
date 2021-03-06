class AlumnosController < ApplicationController
  before_action :set_alumno, only: [:show, :edit, :update, :destroy]

  def index
    @alumnos = Alumno.all
	  #@alumnos = Alumno.filter(params.slice(:nombre, :apellido))
	  @alumnos = Alumno.filter(params, @alumnos)
	  respond_to do |format|
		  format.html
		  format.xlsx #{send_data @alumnos} #not working, nos passing the filter to the excel generator
	  end
  end

  # GET /alumnos/1
  # GET /alumnos/1.json
  def show
  end

  # GET /alumnos/new
  def new
    @alumno = Alumno.new
  end

  # GET /alumnos/1/edit
  def edit
  end

  # POST /alumnos
  # POST /alumnos.json
  def create
    @alumno = Alumno.new(alumno_params)

    respond_to do |format|
      if @alumno.save
        format.html { redirect_to @alumno, notice: 'Estudiante dado de alta satisfactoriamente.' }
        format.json { render :show, status: :created, location: @alumno }
      else
        format.html { render :new }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alumnos/1
  # PATCH/PUT /alumnos/1.json
  def update
    respond_to do |format|
      if @alumno.update(alumno_params)
        format.html { redirect_to @alumno, notice: 'Estudiante actualizado satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @alumno }
      else
        format.html { render :edit }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alumnos/1
  # DELETE /alumnos/1.json
  def destroy
    @alumno.destroy
    respond_to do |format|
      format.html { redirect_to alumnos_url, notice: 'El registro del estudiante ha sido borrado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alumno
      @alumno = Alumno.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alumno_params
      params.require(:alumno).permit(:dni, :nombre, :apellido, :localidad_id, :domicilio, :telefono_fijo, :telefono_celular, :correo, :fecha_nacimiento, :inscripcion_certificado, :inscripcion_foto, :inscripcion_partida, :inscripcion_ficha, :sigae, :comentario, :comentario_inscripcion, :sexo, :sede_id, :alumno_observacion_ids => [])
    end	
end

class AlumnoImportsController < ApplicationController
  def new
    @alumno_import = AlumnoImport.new
  end

  def create
    @alumno_import = AlumnoImport.new(params[:alumno_import])
    if @alumno_import.save
      redirect_to root_url, notice: "Estudiantes importados exitosamente."
    else
      render :new
    end
  end
end

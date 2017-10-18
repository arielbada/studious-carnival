class SeguimientoImportsController < ApplicationController
  def new
    @seguimiento_import = SeguimientoImport.new
  end

  def create
    @seguimiento_import = SeguimientoImport.new(params[:seguimiento_import])
    if @seguimiento_import.save
      redirect_to :seguimientos, notice: "Acta importada exitosamente."
    else
      render :new	  
    end
  end
end

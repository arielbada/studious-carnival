class Seguimiento < ApplicationRecord
  include Filterable
  include Validaciones
  belongs_to :alumno
  belongs_to :seccion
  
  attr_reader :valor_de_acta
  
  def valor_de_acta
    if self.fecha_acta
	  valor_de_acta = true
	else
      valor_de_acta = false
	end
  end
end

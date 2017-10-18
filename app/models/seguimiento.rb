class Seguimiento < ApplicationRecord
  include Filterable
  include Validaciones
  belongs_to :alumno
  belongs_to :seccion
  
end

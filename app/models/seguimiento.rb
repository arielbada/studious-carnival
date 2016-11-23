class Seguimiento < ApplicationRecord
  belongs_to :alumno
  belongs_to :seccion
end

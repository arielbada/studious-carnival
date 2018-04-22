class AlumnoObservacion < ApplicationRecord
  has_and_belongs_to_many :alumno
end

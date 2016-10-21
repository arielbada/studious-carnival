class Alumno < ApplicationRecord
  belongs_to :localidad
  belongs_to :sede
end

class Alumno < ApplicationRecord
  belongs_to :localidad
  belongs_to :sede
  has_many :seguimiento
end

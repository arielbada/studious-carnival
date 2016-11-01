class Alumno < ApplicationRecord
  include Filterable
  belongs_to :localidad
  belongs_to :sede
  has_many :seguimiento
end

class Seguimiento < ApplicationRecord
  include Filterable
  belongs_to :alumno
  belongs_to :seccion
end

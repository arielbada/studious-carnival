class Localidad < ApplicationRecord
	include Filterable
	has_many :alumno
	has_many :sede
end

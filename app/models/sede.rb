class Sede < ApplicationRecord
	include Filterable
	belongs_to :localidad
end

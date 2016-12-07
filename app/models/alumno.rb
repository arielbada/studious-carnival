class Alumno < ApplicationRecord
	include Filterable
	belongs_to :localidad
	has_many :seguimiento

	attr_reader :alumno

	def alumno
		alumno = self.apellido + ", " + self.nombre
	end
end

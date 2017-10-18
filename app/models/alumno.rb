class Alumno < ApplicationRecord
	include Filterable
	belongs_to :localidad
	belongs_to :sede, optional: true
	has_many :seguimiento

	attr_reader :alumno
	validates_presence_of :dni

	def alumno
		alumno = self.apellido + ", " + self.nombre
	end

end

class Alumno < ApplicationRecord
	include Filterable
	belongs_to :localidad, :class_name => "Localidad", :foreign_key => 'localidad_id'
	belongs_to :sede_provincial, :class_name => "Localidad", :foreign_key => 'sede_provincial_id', optional: true
	has_many :seguimiento

	attr_reader :alumno

	def alumno
		alumno = self.apellido + ", " + self.nombre
	end
end

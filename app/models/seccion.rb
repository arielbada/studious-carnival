class Seccion < ApplicationRecord
    include Filterable
	has_many :seguimiento
	attr_accessor  :modulo, :cohorte, :aula
	
	before_save :concatenate_seccion
	
	def concatenate_seccion
		self.seccion = modulo + cohorte + aula
	end
end

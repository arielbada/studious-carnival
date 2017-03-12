class Seccion < ApplicationRecord
    include Filterable
	has_many :seguimiento
	attr_accessor  :cohorte, :modulo, :aula
	
	before_save :concatenate_seccion
	
	def concatenate_seccion
		self.seccion = cohorte + modulo + aula
	end
end

class Alumno < ApplicationRecord
  include Filterable
  belongs_to :localidad
  belongs_to :sede, optional: true
  has_many :seguimiento
  has_and_belongs_to_many :alumno_observacion

  attr_reader :alumno, :observaciones
  validates_presence_of :dni

  def alumno
    alumno = self.apellido + ", " + self.nombre
  end
  
  def observaciones
    # Lists all Observaciones for Alumno
	  observaciones = AlumnoObservacion.includes("alumno").references("alumno").where("alumno_id = ?", self.id).map{ |o| o.observacion }.join(", ")    
  end
  
end

class CreateJoinTableAlumnoObservacionAlumno < ActiveRecord::Migration[5.1]
  def change
    create_join_table :alumno_observaciones, :alumnos do |t|
      # t.index [:alumno_observacion_id, :alumno_id]
      t.index [:alumno_id, :alumno_observacion_id], unique: true, name: 'index_alumno_alumno_observacion'
    end
  end
end

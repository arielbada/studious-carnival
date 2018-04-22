class CreateAlumnoObservaciones < ActiveRecord::Migration[5.1]
  def change
    create_table :alumno_observaciones do |t|
      t.string :observacion

      t.timestamps
    end
  end
end

class CreateAlumnos < ActiveRecord::Migration[5.0]
  def change
    create_table :alumnos do |t|
      t.string :dni
      t.string :nombre
      t.string :apellido
      t.references :localidad, foreign_key: true
      t.string :domicilio
      t.string :telefono_fijo
      t.string :telefono_celular
      t.string :correo
      t.date :fecha_nacimiento
      t.references :sede, foreign_key: true
      t.boolean :inscripcion_certificado
      t.boolean :inscripcion_foto
      t.boolean :inscripcion_partida
      t.boolean :inscripcion_ficha

      t.timestamps
    end
  end
end

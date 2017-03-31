class AddComentarioAndComentarioInscripcionToAlumnos < ActiveRecord::Migration[5.0]
  def change
    add_column :alumnos, :comentario, :string
    add_column :alumnos, :comentario_inscripcion, :string
  end
end

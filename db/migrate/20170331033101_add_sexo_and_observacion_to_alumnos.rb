class AddSexoAndObservacionToAlumnos < ActiveRecord::Migration[5.0]
  def change
    add_column :alumnos, :sexo, :string
    add_column :alumnos, :observacion, :string
  end
end

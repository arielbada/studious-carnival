class AddEstadoCursadoToAlumnos < ActiveRecord::Migration[5.0]
  def change
    add_column :alumnos, :estado_cursado, :string
  end
end

class RemoveEstadoCursadoFromAlumnos < ActiveRecord::Migration[5.0]
  def change
    remove_column :alumnos, :estado_cursado, :string
  end
end

class RemoveObservacionFromAlumnos < ActiveRecord::Migration[5.1]
  def change
    remove_column :alumnos, :observacion, :string
  end
end

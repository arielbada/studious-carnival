class RemoveSedeFromAlumnos < ActiveRecord::Migration[5.0]
  def change
    remove_column :alumnos, :sede_id
  end
end

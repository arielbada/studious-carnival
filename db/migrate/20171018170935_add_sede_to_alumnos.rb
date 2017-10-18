class AddSedeToAlumnos < ActiveRecord::Migration[5.0]
  def change
    add_reference :alumnos, :sede, foreign_key: true
  end
end

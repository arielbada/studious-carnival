class AddSedeProvincialToAlumnos < ActiveRecord::Migration[5.0]
  def change
    add_reference :alumnos, :sede_provincial
  end
end

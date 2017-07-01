class AddLocalidadToSedes < ActiveRecord::Migration[5.0]
  def change
    add_reference :sedes, :localidad, foreign_key: true
  end
end

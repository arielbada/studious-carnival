class AddFechaInicioAndFechaFinalizacionToSecciones < ActiveRecord::Migration[5.0]
  def change
    add_column :secciones, :fecha_inicio, :date
    add_column :secciones, :fecha_finalizacion, :date
  end
end

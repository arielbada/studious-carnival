class AddColumnsToSedes < ActiveRecord::Migration[5.0]
  def change
    add_column :sedes, :email, :string
    add_column :sedes, :telefono_contacto, :string
    add_column :sedes, :email_contacto, :string
    add_column :sedes, :tipo_sede_conectividad, :boolean
	add_column :sedes, :tipo_sede_presencial, :boolean
	add_column :sedes, :tipo_sede_consulta, :boolean
    add_column :sedes, :tiene_pc, :boolean
    add_column :sedes, :tiene_internet, :boolean
    add_column :sedes, :observaciones, :string
  end
end

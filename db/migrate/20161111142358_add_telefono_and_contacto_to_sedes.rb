class AddTelefonoAndContactoToSedes < ActiveRecord::Migration[5.0]
  def change
    add_column :sedes, :telefono, :string
    add_column :sedes, :nombre_contacto, :string
  end
end

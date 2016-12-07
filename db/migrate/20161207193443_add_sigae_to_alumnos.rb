class AddSigaeToAlumnos < ActiveRecord::Migration[5.0]
  def change
    add_column :alumnos, :sigae, :boolean
  end
end

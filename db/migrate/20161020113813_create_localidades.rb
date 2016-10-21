class CreateLocalidades < ActiveRecord::Migration[5.0]
  def change
    create_table :localidades do |t|
      t.string :localidad
      t.string :region_educativa
      t.string :nodo

      t.timestamps
    end
  end
end

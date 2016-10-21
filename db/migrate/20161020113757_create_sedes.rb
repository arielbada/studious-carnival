class CreateSedes < ActiveRecord::Migration[5.0]
  def change
    create_table :sedes do |t|
      t.string :escuela
      t.string :direccion

      t.timestamps
    end
  end
end

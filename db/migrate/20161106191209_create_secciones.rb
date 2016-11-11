class CreateSecciones < ActiveRecord::Migration[5.0]
  def change
    create_table :secciones do |t|
      t.string :seccion

      t.timestamps
    end
  end
end

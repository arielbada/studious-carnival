class CreateSeguimientos < ActiveRecord::Migration[5.0]
  def change
    create_table :seguimientos do |t|
      t.references :alumno, index:true, foreign_key: true
      t.string :cohorte, index:true
      t.string :modulo, index:true
      t.date :fecha_acta, index:true
      t.string :aula
      t.string :estado
      t.integer :calificacion

      t.timestamps
    end
  end
end

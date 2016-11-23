class AddSeccionToSeguimientos < ActiveRecord::Migration[5.0]
  def change
    add_reference :seguimientos, :seccion, foreign_key: true
  end
end

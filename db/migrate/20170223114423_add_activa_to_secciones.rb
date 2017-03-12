class AddActivaToSecciones < ActiveRecord::Migration[5.0]
  def change
    add_column :secciones, :activa, :boolean
  end
end

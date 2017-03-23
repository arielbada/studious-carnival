class RemoveActivaFromSecciones < ActiveRecord::Migration[5.0]
  def change
    remove_column :secciones, :activa, :boolean
  end
end
